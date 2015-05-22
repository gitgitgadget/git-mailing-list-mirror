From: FusionX86 <fusionx86@gmail.com>
Subject: Re: git p4 clone - exclude file types
Date: Thu, 21 May 2015 19:33:44 -0600
Message-ID: <CAFcBi884jBq9a7v8cATMkT3Wh75zmuW9mc8DfA5ZYLcCXEQEHw@mail.gmail.com>
References: <CAFcBi88K-HEn4JCVkONq3h4O9XS1FFX0OXch2d-VJ2bLEsPM0g@mail.gmail.com>
	<555A52BD.1030802@diamand.org>
	<CAFcBi89XwW48Goaap=OCVQ_CJrNa_hj5+DWtOHGOsrm6jMs-mw@mail.gmail.com>
	<555C2E5D.70502@diamand.org>
	<CAFcBi8-SShvWLS7sRy3L=vF=OmQqmroK5NpcuA9N=0J2x4DEXA@mail.gmail.com>
	<555E5304.5030502@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri May 22 03:33:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvbqW-0001A3-Ju
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 03:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145AbbEVBdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 21:33:46 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33924 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbbEVBdp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 21:33:45 -0400
Received: by qgez61 with SMTP id z61so2197198qge.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 18:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ras1LXz53Q4BiBa+5xL4CTzvXt8Y2qJl/jp3ZD3i8W4=;
        b=JsV6D8GMqYAwJRF3vgWG8xlTaJLKrnVNqmfBmoQoXkTsp939maBMouev/XwP5aDaGB
         AUiOW3ar8BSJ0o+cqd3wKp1VjD9Y0cKbNvXBkoEESGWR5CxWIxMpNUjHjU91xrb+wJiO
         eKmTktlLKlV1ymVo61BQVBXdxmmTFt82eUnyuR4Z/nJfXu37MvktCc97oMn7ParrPUz4
         qozWomusjwSvQ9E/WOxTKu0dmrq0EEQdGA0EYdvanLXZaZfWxfRoN56h3FT6KSZhiFN5
         CKSI8VsLuZsb8SYFiDRCdAPFNUDMehgIFVmcnc0IIFcDFKwJKAqeNNhUPLg3IWFJRk/d
         Jg2A==
X-Received: by 10.140.88.242 with SMTP id t105mr7622407qgd.92.1432258424725;
 Thu, 21 May 2015 18:33:44 -0700 (PDT)
Received: by 10.140.93.44 with HTTP; Thu, 21 May 2015 18:33:44 -0700 (PDT)
In-Reply-To: <555E5304.5030502@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269683>

Sure, but it doesn't show anything other than the last file that
p4/git was working on. It's always a different file, but looks
something like this:

/path/to/file/somefile1
/path/to/file/somefile2

and then just hangs...

It is trying to clone ~42846 files.

The p4d server version is older. It hasn't been maintained and we have
no support. The version is: P4D/NTX64/2012.1/459601 (2012/05/09)

The single CPU does hit 100% at times, but it doesn't last and load is
never high. Thought about adding a second CPU to see if it helps by
chance. This isn't a show stopper since I can eventually get it to
work if I keep trying, but figured I'd send it out to the community.

On Thu, May 21, 2015 at 3:49 PM, Luke Diamand <luke@diamand.org> wrote:
> On 21/05/15 21:49, FusionX86 wrote:
>>
>> I thought about that, but no. The box I'm running git-p4 on has the
>> following specs:
>>
>> CentOS 6.6 64bit
>> 1 CPU
>> 8GB RAM
>> 8GB Swap
>
>
> Can you post the output, with "-v" added?
>
> $ git-p4 clone //depot/some/dir -v
>
> Also, what is your p4d server version?
>
> $ p4 info
>
> A quick test just cloning a repo with 4 files of 256MB each seems fine,
> FWIW.
>
>
>>
>> It is also on the same physical network as the Perforce server. I
>> remember seeing someone else complain about this, but I can't find the
>> article/blog now.
>>
>>
>> On Wed, May 20, 2015 at 12:49 AM, Luke Diamand <luke@diamand.org> wrote:
>>>
>>> On 19/05/15 08:38, FusionX86 wrote:
>>>>
>>>>
>>>> Thanks Luke, looks like this does work for excluding files when using
>>>> git p4. Great!
>>>>
>>>> Unrelated question...
>>>>
>>>> While using git p4 I have noticed that most of the time the clone/sync
>>>> operations hang and I have to keep retrying. The Perforce depot I'm
>>>> currently working with is larger than I'd like and has a lot of binary
>>>> files which might be the cause. The point it gets to in the clone/sync
>>>> is always random and doesn't ever stop on the same files or file
>>>> types. Sometimes it'll die soon after starting, but other times it
>>>> almost completes and then dies. If I keep retrying, it will eventually
>>>> complete. I haven't been able to narrow down the cause, but I do
>>>> notice that the git-fast-import stops right as the clone/sync dies.
>>>> I'm wondering if git is overwhelmed and terminates. Have you ever seen
>>>> this? Any suggestions?
>>>
>>>
>>>
>>> Running out of memory?
>>>
>>> Is this on a 32bit or 64bit system? How much virtual memory do you have?
>>>
>>> Luke
>>>
>
