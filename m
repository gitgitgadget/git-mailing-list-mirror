From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Tue, 07 May 2013 05:27:33 +0200
Message-ID: <518874A5.5050002@alum.mit.edu>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com> <1367555502-4706-5-git-send-email-felipe.contreras@gmail.com> <87y5bw3q1s.fsf@hexa.v.cablecom.net> <CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com> <518785B3.3050606@alum.mit.edu> <87ip2wflg0.fsf@linux-k42r.v.cablecom.net> <518789D1.4010905@alum.mit.edu> <CAMP44s1Nk7YAjNkTq=ShQbzkMasw6bpcEPTXLb8x+2q-vXLRGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 07 05:27:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZYZ5-0007nR-CH
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 05:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243Ab3EGD1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 23:27:38 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:53643 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757399Ab3EGD1h (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 May 2013 23:27:37 -0400
X-AuditID: 12074411-b7f286d0000008e8-e6-518874a82f5c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 67.39.02280.8A478815; Mon,  6 May 2013 23:27:36 -0400 (EDT)
Received: from [192.168.69.140] (p57A24E33.dip0.t-ipconnect.de [87.162.78.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r473RXn0015386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 6 May 2013 23:27:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAMP44s1Nk7YAjNkTq=ShQbzkMasw6bpcEPTXLb8x+2q-vXLRGg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqLuipCPQ4MFPdYtfZ3exWBx8nGfR
	daWbyaKh9wqzRf/yLjaLu5dXsTuweeycdZfd48PHOI/br+cze1y8pOzxeZNcAGsUt01SYklZ
	cGZ6nr5dAnfGhp0nmQqWKVb86O5jbGD8LtXFyMkhIWAiMXnyT0YIW0ziwr31bF2MXBxCApcZ
	JXp3T2KGcM4ySdzbfowJpIpXQFuif81ioAQHB4uAqsSqDYogYTYBXYlFPc1gJaICYRKr1i9j
	higXlDg58wkLiC0iYCixt30qC8hMZoHzjBIHPzxhB0kIC9hL7PoynRVi2UJmifNvWtlAEpwC
	gRL7Vl1gAlnGLKAusX6eEEiYWUBeYvvbOcwTGAVmIdkxC6FqFpKqBYzMqxjlEnNKc3VzEzNz
	ilOTdYuTE/PyUot0TfVyM0v0UlNKNzFCAl1wB+OMk3KHGAU4GJV4eBVOtQcKsSaWFVfmHmKU
	5GBSEuX1LO4IFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCK60NlONNSaysSi3Kh0lJc7AoifPy
	LVH3ExJITyxJzU5NLUgtgsnKcHAoSfB2gwwVLEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUos
	LcmIB0VqfDEwVkFSPEB7g0DaeYsLEnOBohCtpxh1OVZeefKaUYglLz8vVUqcdzFIkQBIUUZp
	HtwKWFp7xSgO9LEwbwlIFQ8wJcJNegW0hAloSQJfO8iSkkSElFQD47ydZ688XGzhc/xLZ6Ww
	838jLcmDan4n6lNzS5iFGt9s10qZW+oe3/A44G9M6/a5Z7ULtofZPb5j7X//gqWo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223535>

On 05/06/2013 11:04 PM, Felipe Contreras wrote:
> On Mon, May 6, 2013 at 5:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 05/06/2013 12:32 PM, Thomas Rast wrote:
>>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>>
>>>> On 05/03/2013 08:23 PM, Felipe Contreras wrote:
>>>>> On Fri, May 3, 2013 at 12:56 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>>
>>>>>> How do we know that this doesn't break any users of fast-import?  Your
>>>>>> comment isn't very reassuring:
>>>>>>
>>>>>>> the vast majority of them will never be used again
>>>>>>
>>>>>> So what's with the minority?
>>>>>
>>>>> Actually I don't think there's any minority. If the client program
>>>>> doesn't store blobs, the blob marks are not used anyway. So there's no
>>>>> change.
>>>>
>>>> I haven't been following this conversation in detail, but your proposed
>>>> change sounds like something that would break cvs2git [1].  Let me
>>>> explain what cvs2git does and why:
>>>>
>>>> CVS stores all of the revisions of a single file in a single filename,v
>>>> file in rcsfile(5) format.  The revisions are stored as deltas ordered
>>>> so that a single revision can be reconstructed from a single serial read
>>>> of the file.
>>>>
>>>> cvs2git reads each of these files once, reconstructing *all* of the
>>>> revisions for a file in a single go.  It then pours them into a
>>>> git-fast-import stream as blobs and sets a mark on each blob.
>>>>
>>>> Only much later in the conversion does it have enough information to
>>>> reconstruct tree-wide commits.  At that time it outputs git-fast-import
>>>> data (to a second file) defining the git commits and their ancestry.
>>>> The contents are defined by referring to the marks of blobs from the
>>>> first git-fast-import stream file.
>>>>
>>>> This strategy speeds up the conversion *enormously*.
>>>>
>>>> So if I understand correctly that you are proposing to stop allowing
>>>> marks on blob objects to be set and/or referred to later, then I object
>>>> vociferously.
>>>
>>> The proposed patch wants to stop writing marks (in --export-marks) for
>>> anything but commits.  Does cvs2git depend on that?  I.e., are you using
>>> two separate fast-import processes for the blob and tree/commit phases
>>> you describe above?
>>
>> Yes, it can be handy to start loading the first "blobfile" in parallel
>> with the later stages of the conversion, before the second "dumpfile" is
>> ready.  In that case the user needs to pass --export-marks to the first
>> fast-import process to export marks on blobs so that the marks can be
>> passed to the second fast-import via --import-marks.
> 
> It can be used that way, but it doesn't have to be.

Please see my other email for an explanation of how the flexibility of
loading the two files separately can bring concrete benefits.

>> So the proposed change would break a documented use of cvs2git.
> 
> It's documented as an alternative. How many people actually use this
> form over the other? Is there really any advantage? It's possibly that
> basically nobody is using this form, and there's no benefits.

You conjectured earlier that nobody uses blob marks, and I provided a
counterexample.  Then you proposed a workaround that would require
changes to the cvs2git documentation, and I even explained how your
proposed workaround is not as flexible as the status quo.  Do you want
to go through the same argument with every possible user of git-fast-import?

It would be insanity to change the default behavior when a workaround on
the Git side (namely adding an option that tells git-fast-import *not*
to emit blob marks) would be quite straightforward to implement and have
little maintenance cost.

>> Making the export of blob marks optional would of course be OK, as long
>> as the default is to export them.
> 
> Nobody benefits from leaving the default as it is.

Sure they do.  Any tool that *knows* that it doesn't need blob marks can
pass the new option and benefit.  Other tools benefit from not being
broken by your change.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
