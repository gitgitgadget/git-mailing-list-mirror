From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFD 0/3] worktree.* config keys and submodule and multiple
 worktrees
Date: Sun, 08 Feb 2015 09:41:33 -0800
Message-ID: <54D79FCD.6060602@web.de>
References: <1423401394-13675-1-git-send-email-pclouds@gmail.com> <54D79EAB.6060301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 18:41:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKVrl-0006LM-6m
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 18:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbbBHRls convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 12:41:48 -0500
Received: from mout.web.de ([212.227.15.14]:61253 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866AbbBHRls (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 12:41:48 -0500
Received: from [192.168.7.132] ([50.204.239.148]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M2MZY-1XSXhP0vWW-00s71I; Sun, 08 Feb 2015 18:41:39
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <54D79EAB.6060301@web.de>
X-Provags-ID: V03:K0:a91K7280JZ1WA5k/qJSfT0M2pRAKBrrRmnQGdy003BbCUdKQ6/g
 /xJlLgkuIw8QDehQ9h2cFiStiTPtQl+RfqaqWpjb6hExQHNfW9A4LJUhlw+o44TGtcWEe1t
 ug4hlDgmujKltZdytUeJBd2aNgWsATSj+drftEqdfh7uJWtqzQBGXVtFbr7z1LiLu/PtHLi
 3rxwI29gMD+jic6bAMJXg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263530>

Am 08.02.2015 um 09:36 schrieb Jens Lehmann:
> Am 08.02.2015 um 05:16 schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy:
>> 1/3 is a more complete version of a patch I posted earlier [1]. It
>> makes sure that worktree.* config keys are stored in a different pla=
ce
>> than $GIT_DIR/config. This allows us to work around the core.worktre=
e
>> issue in multiple worktree setting.
>>
>> I think 1/3 and 2/3 are fine. 3/3 is probably not. It's more of a
>> proof of concept. The tests pass, but there's no migration path for
>> existing submodules. Submodules modified by new Git will confuse old
>> Git because the old ones do not understand worktree.path (the
>> replacement for core.worktree)
>
> Yeah, breaking every submodule cloned with v1.7.9 or newer is not

That's v1.7.8 of course ...

> the way to go. You'd still have to support the old configuration
> name for a very long time.
>
> I wonder if it's worth all the hassle to invent new names. Wouldn't
> it be much better to just keep a list of per-worktree configuration
> value names and use that inside the config code to decide where to
> find them for multiple work trees. That would also work easily for
> stuff like EOL-config and would push the complexity in the config
> machinery and not onto the user.
