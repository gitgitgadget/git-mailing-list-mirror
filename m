From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git-contacts questions
Date: Tue, 29 Oct 2013 15:39:06 +0100
Message-ID: <vpqsivkywdx.fsf@anie.imag.fr>
References: <CAHGBnuPW3dtiL-=6BgvaOB4VvOAPyZhrVS3WGreVH_Pt81=wyg@mail.gmail.com>
	<CAMP44s1+npNnR8-exARL8kamQ81JwyLhhQnnkv6DvK8e3qOfHA@mail.gmail.com>
	<CAHGBnuP6nyTCGGNntvWVYAtxNX9xgt6=F3HheiEUcPU_9TP-1g@mail.gmail.com>
	<CAMP44s2KdHPH-UaSwdiJtT8WNo7uT9K_ArXwqHhCryPRsX1qjA@mail.gmail.com>
	<CAHGBnuNWtgH_aYxv0gX44AkGTRo6vsKdd4w1cViLGD9O9RLaNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 15:39:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbAS2-0000YT-6y
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 15:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab3J2OjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 10:39:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51375 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292Ab3J2OjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 10:39:16 -0400
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r9TEd5w9005322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Oct 2013 15:39:05 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id r9TEd6aJ005412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 29 Oct 2013 15:39:06 +0100
In-Reply-To: <CAHGBnuNWtgH_aYxv0gX44AkGTRo6vsKdd4w1cViLGD9O9RLaNQ@mail.gmail.com>
	(Sebastian Schuberth's message of "Tue, 29 Oct 2013 15:17:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 29 Oct 2013 15:39:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r9TEd5w9005322
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1383662349.20109@DH3ub5SlHlR7mzuOA1sUkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236928>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Tue, Oct 29, 2013 at 11:35 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Tue, Oct 29, 2013 at 3:12 AM, Sebastian Schuberth
>> <sschuberth@gmail.com> wrote:
>>> On Tue, Oct 29, 2013 at 9:57 AM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>
>>>>> 1) Passing just "HEAD" as a committish like in "git contacts HEAD"
>>>>> does not output anything for me, but using the SHA1 for HEAD does
>>>>> neither. My HEAD commit does not add any files, but only modifies
>>>>> previously existing files, so I would have expected some output. In
>>>>> case it turns out to be correct to have no output in my case, could we
>>>>> probably say that in some message to the user?
>>>>
>>>> It should be HEAD^, or -1, like with 'git format-patch'.
>>>
>>> Oh, that's pretty much unexpected. Wouldn't it be much more natural if
>>> I had to specify the commit(s) that introduce(s) the changes that I
>>> want others to look at?
>>
>> Yeah, that's exactly what you are doing. How do you tell 'git log' to
>> show you certain changes?
>
> I'm not sure what you're trying to point me at. It's clear that from
> an implementation view you need to blame HEAD^ if you need to know
> which poeple should review your changes in HEAD.

I agree that the situation when providing only HEAD is really
disappointing...

> But IMHO that is an implementation detail that should be hidden from
> the user.

... but it's not just an implementation detail: git-contacts takes a
range of commits, so you can ask for people to Cc for a whole patch
series for example.

If I understand correctly, "git contact $ONE_COMMIT" does
"git contact $ONE_COMMIT..HEAD" implicitly, and this is weird when
$ONE_COMMIT is HEAD.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
