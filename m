From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: Test failure: Test #3 in t1304-default-acl
Date: Mon, 1 Oct 2012 10:08:23 +0200
Message-ID: <k4bj1v$pav$1@ger.gmane.org>
References: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com> <vpqy5k8raig.fsf@grenoble-inp.fr> <CALkWK0=h6iU_J=X6MFgLXPfo0rh236cTuVaU3nNSnAaikjKH5w@mail.gmail.com> <vpqd31kr7v4.fsf@grenoble-inp.fr> <CALkWK0=ROz8fxXgnqt-+AthU-hgq_mzFg0GhBQCrAshH_mRBPQ@mail.gmail.com> <vpqvcfcps2z.fsf@grenoble-inp.fr> <7v4nmwwqox.fsf@alter.siamese.dyndns.org> <vpqipbcpp69.fsf@grenoble-inp.fr> <7vvcfctmka.fsf@alter.siamese.dyndns.org> <CALkWK0m9tkRXFZw-d_XADR9LXqxa0j_82bhhrd0FoEoHsO6yPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 10:09:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIb3v-00034P-Hz
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 10:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237Ab2JAII4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 04:08:56 -0400
Received: from plane.gmane.org ([80.91.229.3]:56072 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752125Ab2JAIIv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 04:08:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TIb3b-0002QI-TP
	for git@vger.kernel.org; Mon, 01 Oct 2012 10:08:51 +0200
Received: from dsdf-4d0a1cfd.pool.mediaways.net ([77.10.28.253])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 10:08:51 +0200
Received: from jojo by dsdf-4d0a1cfd.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 10:08:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4d0a1cfd.pool.mediaways.net
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206725>

Ramkumar Ramachandra wrote:
> Hi Junio,
>
> Junio C Hamano wrote:
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> I haven't been paying attention, but does that mean on that system,
>>>> a total stranger kseygold can write, modify, and remove whatever
>>>> Ram owns?  I am hoping that is not the case.
>>>
>>> I can see two reasons for having the same UID for two login names:
>>>
>>> 1) the sysadmin really messed up, and as you say, a total stranger
>>> has complete ownership of your files. Ramkumar, you should check
>>> that this is not your case.
>>>
>>> 2) the sysadmin explicitely gave two login names to the same
>>> physical person, as kinds of aliases for the same UID (e.g. the
>>> person got married, changed her name and login, but expects
>>> ~oldlogin to continue working). I'm not sure how common this is,
>>> and to which extend we want to support this in our test scripts.
>>
>> I've only been assuming (1), but (2) feels like a legitimate (if
>> confusing) way to configure your system.
>>
>> It is a separate issue if it is worth bending backwards to support
>> it in the test, though.
>
> For what it's worth, `sudo` is "broken" on my system.

sudo can't deal properly with multiple users sharing a UID, as it uses 
getpwuid(getuid()) in places.
On my system I've replaced that with getgwnam(getlogin()). which seems to 
work fine here.

Bye, Jojo 
