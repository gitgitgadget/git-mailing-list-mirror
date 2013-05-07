From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Tue, 07 May 2013 04:58:45 +0200
Message-ID: <51886DE5.7030001@alum.mit.edu>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com> <1367555502-4706-5-git-send-email-felipe.contreras@gmail.com> <87y5bw3q1s.fsf@hexa.v.cablecom.net> <CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com> <518785B3.3050606@alum.mit.edu> <87ip2wflg0.fsf@linux-k42r.v.cablecom.net> <518789D1.4010905@alum.mit.edu> <7v38u0t9va.fsf@alter.siamese.dyndns.org> <CAMP44s1HASAuF0ECCvJr66WeqopDzLZQ12pKFsc-j5_VCDrizg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 07 04:58:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZY7F-0002jM-0k
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 04:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758990Ab3EGC6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 22:58:53 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:53416 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756110Ab3EGC6w (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 May 2013 22:58:52 -0400
X-AuditID: 12074414-b7fb86d000000905-2d-51886deb560b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id A7.05.02309.BED68815; Mon,  6 May 2013 22:58:51 -0400 (EDT)
Received: from [192.168.69.140] (p57A24E33.dip0.t-ipconnect.de [87.162.78.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r472wk1f014001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 6 May 2013 22:58:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAMP44s1HASAuF0ECCvJr66WeqopDzLZQ12pKFsc-j5_VCDrizg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsUixO6iqPs6tyPQ4NgaXotfZ3exWBx8nGfR
	daWbyaKh9wqzRf/yLjaLu5dXsTuweeycdZfd48PHOI/br+cze1y8pOzxeZNcAGsUt01SYklZ
	cGZ6nr5dAnfGypZrTAUTFSp+TdrO2MB4W7KLkZNDQsBEYlnHM3YIW0ziwr31bF2MXBxCApcZ
	JRof/2aEcM4ySfy+tpoJpIpXQFvi2MP7LCA2i4CqxPH3a5hBbDYBXYlFPc1gNaICYRKr1i9j
	hqgXlDg58wlYvYiAocTe9qksIEOZBY4xSuzpvAC2WljAXmLXl+msENtOM0v0r1/LBpLgFAiU
	mL3pA1AHB1CHusT6eUIgYWYBeYntb+cwT2AUmIVkxyyEqllIqhYwMq9ilEvMKc3VzU3MzClO
	TdYtTk7My0st0rXQy80s0UtNKd3ECAl1kR2MR07KHWIU4GBU4uFVONUeKMSaWFZcmXuIUZKD
	SUmUlzu9I1CILyk/pTIjsTgjvqg0J7X4EKMEB7OSCK+0NlCONyWxsiq1KB8mJc3BoiTO+22x
	up+QQHpiSWp2ampBahFMVoaDQ0mC1zEHqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0
	JCMeFKvxxcBoBUnxAO3lAmnnLS5IzAWKQrSeYtTlWHnlyWtGIZa8/LxUKXHex9lARQIgRRml
	eXArYIntFaM40MfCvAtBRvEAkyLcpFdAS5iAliTwtYMsKUlESEk1ME4pX3NiM9u2KosmhZAv
	ui7n5vjLXFx/one3VLBLzfXn8/7qTVjccbG1WmqD8O1p8Ye37KhUUJjcN3HiqkVa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223532>

On 05/06/2013 11:19 PM, Felipe Contreras wrote:
> On Mon, May 6, 2013 at 10:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> Yes, it can be handy to start loading the first "blobfile" in parallel
>>> with the later stages of the conversion, before the second "dumpfile" is
>>> ready.  In that case the user needs to pass --export-marks to the first
>>> fast-import process to export marks on blobs so that the marks can be
>>> passed to the second fast-import via --import-marks.
>>>
>>> So the proposed change would break a documented use of cvs2git.
>>>
>>> Making the export of blob marks optional would of course be OK, as long
>>> as the default is to export them.
>>
>> Thanks for a concise summary.  Your use case fits exactly what
>> Felipe conjectured as the nonexistent minority.
> 
> Not true. cvs2git does *not* rely on the blobs being stored in a marks
> file, because cvs2git does not rely on mark files at all.
> 
>> An option that lets the caller say "I only care about marks on these
>> types of objects to be written to (and read from) the exported marks
>> file" would help Felipe's use case without harming your use case,
>> and would be a sane and safe way to go.
> 
> His case is not harmed at all. It's only the unfortunate command that
> is mentioned in the documentation that didn't need to be mentioned at
> all in the first place.
> 
> It should be the other way around, if it's only this documentation
> that is affected, we could add a switch for that particular command,
> and the documentation should be updated, but it's overkill to add a
> switch for one odd command in some documentation somewhere, it would
> be much better to update the odd command to avoid using marks at all,
> which is what the more appropriate command does, right below in the
> same documentation.
> 
>   cat ../cvs2svn-tmp/git-blob.dat ../cvs2svn-tmp/git-dump.dat | git fast-import
> 
> Should the rest of the real world be punished because somebody added a
> command in some documentation somewhere, which wasn't actually needed
> in the first place?

Don't get too fixated on the documentation.  The documentation just
gives some examples of how cvs2git can be used.

The reason that cvs2git outputs two files is that the first file is
emitted at the very beginning of the conversion and the second at the
very end.  These conversions can take a long time (> 1 day for very big
repos), can be interrupted and restarted between "passes", and passes
can even be re-run with changed configurations.

CVS write access has to be turned off before the start of the final
conversion, so no VCS is possible until the conversion is over.  So
users are very interested in keeping the downtime minimal.  The blobfile
can also be unwieldy (its size is approximately the sum of the sizes of
all revisions of all files in the project).  Being able to load the
blobfile into one fast-import process and the dumpfile into a different
process (which relies on the feature that you propose removing) opens up
a lot of possibilities:

* The first fast-import of the blobfile can be started as soon as the
blobfile is complete and run in parallel with the rest of the conversion.

* If the blobfile needs to be transferred over the network (e.g.,
because Git will be served from a different server than the one doing
the conversion) the network transfer can also be done in parallel with
the rest of the conversion.

* The blobfile could be written to a named pipe that is being read by a
git-fast-import process, to avoid having to write the blobfile to disk
in the first place.

* The user could run "git repack" between loading the blobfile and
loading the dumpfile.

These are just the ways that cvs2git does and/or could benefit from the
flexibility that is now in git-fast-import.  Other tools might also be
using git-fast-import in ways that would be broken by your proposed change.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
