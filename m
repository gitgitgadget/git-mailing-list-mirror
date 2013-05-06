From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Mon, 06 May 2013 12:45:37 +0200
Message-ID: <518789D1.4010905@alum.mit.edu>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com> <1367555502-4706-5-git-send-email-felipe.contreras@gmail.com> <87y5bw3q1s.fsf@hexa.v.cablecom.net> <CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com> <518785B3.3050606@alum.mit.edu> <87ip2wflg0.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 06 12:45:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZIvR-0005lF-L8
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 12:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab3EFKpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 06:45:41 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:54764 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752985Ab3EFKpl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 May 2013 06:45:41 -0400
X-AuditID: 12074412-b7f216d0000008d4-10-518789d4c2ca
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.78.02260.4D987815; Mon,  6 May 2013 06:45:40 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r46AjbEc002087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 6 May 2013 06:45:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <87ip2wflg0.fsf@linux-k42r.v.cablecom.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsUixO6iqHulsz3QYP4tYYtfZ3exWBx8nGfR
	daWbyaKh9wqzRf/yLjaLu5dXsTuweeycdZfd48PHOI/br+cze1y8pOzxeZNcAGsUt01SYklZ
	cGZ6nr5dAnfGt9e72AvOi1b0n//N1sC4SbCLkZNDQsBE4tDvb6wQtpjEhXvr2boYuTiEBC4z
	Shx5u54RwjnGJHHu9j0WkCpeAW2JhX/XMIHYLAKqEn9uzGcHsdkEdCUW9TSDxUUFwiRWrV/G
	DFEvKHFy5hOgXg4OEQFliW0La0DCzAJ3GSV6+7hBbGEBe4ldX6azQuzawyTx5u8VRpAEp4C5
	xKzZ8xkhGnQk3vU9YIaw5SW2v53DPIFRYBaSFbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJu
	cXJiXl5qka6ZXm5miV5qSukmRkioC+1gXH9S7hCjAAejEg9v4ZO2QCHWxLLiytxDjJIcTEqi
	vP872gOF+JLyUyozEosz4otKc1KLDzFKcDArifD67AUq501JrKxKLcqHSUlzsCiJ8/5crO4n
	JJCeWJKanZpakFoEk5Xh4FCS4HUGxrSQYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlG
	PChW44uB0QqS4gHamw/SzltckJgLFIVoPcWoy7HyypPXjEIsefl5qVLivIYgRQIgRRmleXAr
	YIntFaM40MfCvCkgVTzApAg36RXQEiagJQl8YEtKEhFSUg2M66O9VJo7V9dtPfdoSjTz4dim
	hDszI472iR09+4XjQmZSzJqlWyrO3VvZuCGdbc+S/x3zcg8qFM66nyBw5deyLaUW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223440>

On 05/06/2013 12:32 PM, Thomas Rast wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 05/03/2013 08:23 PM, Felipe Contreras wrote:
>>> On Fri, May 3, 2013 at 12:56 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> How do we know that this doesn't break any users of fast-import?  Your
>>>> comment isn't very reassuring:
>>>>
>>>>> the vast majority of them will never be used again
>>>>
>>>> So what's with the minority?
>>>
>>> Actually I don't think there's any minority. If the client program
>>> doesn't store blobs, the blob marks are not used anyway. So there's no
>>> change.
>>
>> I haven't been following this conversation in detail, but your proposed
>> change sounds like something that would break cvs2git [1].  Let me
>> explain what cvs2git does and why:
>>
>> CVS stores all of the revisions of a single file in a single filename,v
>> file in rcsfile(5) format.  The revisions are stored as deltas ordered
>> so that a single revision can be reconstructed from a single serial read
>> of the file.
>>
>> cvs2git reads each of these files once, reconstructing *all* of the
>> revisions for a file in a single go.  It then pours them into a
>> git-fast-import stream as blobs and sets a mark on each blob.
>>
>> Only much later in the conversion does it have enough information to
>> reconstruct tree-wide commits.  At that time it outputs git-fast-import
>> data (to a second file) defining the git commits and their ancestry.
>> The contents are defined by referring to the marks of blobs from the
>> first git-fast-import stream file.
>>
>> This strategy speeds up the conversion *enormously*.
>>
>> So if I understand correctly that you are proposing to stop allowing
>> marks on blob objects to be set and/or referred to later, then I object
>> vociferously.
> 
> The proposed patch wants to stop writing marks (in --export-marks) for
> anything but commits.  Does cvs2git depend on that?  I.e., are you using
> two separate fast-import processes for the blob and tree/commit phases
> you describe above?

Yes, it can be handy to start loading the first "blobfile" in parallel
with the later stages of the conversion, before the second "dumpfile" is
ready.  In that case the user needs to pass --export-marks to the first
fast-import process to export marks on blobs so that the marks can be
passed to the second fast-import via --import-marks.

So the proposed change would break a documented use of cvs2git.

Making the export of blob marks optional would of course be OK, as long
as the default is to export them.

Michael


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
