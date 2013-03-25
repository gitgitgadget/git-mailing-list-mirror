From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Bug: `gitsubmodule` does not list modules with unicode characters
Date: Mon, 25 Mar 2013 09:30:44 +0100
Message-ID: <51500B34.30801@web.de>
References: <loom.20130323T171809-46@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ilya Kulakov <kulakov.ilya@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 09:31:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK2oO-000569-Dk
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 09:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723Ab3CYIar convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 04:30:47 -0400
Received: from mout.web.de ([212.227.17.12]:54072 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756597Ab3CYIaq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 04:30:46 -0400
Received: from [192.168.178.41] ([91.3.170.222]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MMEzJ-1UJENt1JBl-007vqh; Mon, 25 Mar 2013 09:30:44
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <loom.20130323T171809-46@post.gmane.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:46jEJlAyd2pVdHx5rrK4uyL6nQpGk61WSy5OATm5qR7
 +DumnnkMm91tAQc3tkI3T78tyYiMHP4OfIQOsSbJ9FSD2QZPxh
 1m9h+/xNXSRSrE3E/y584eTLHDfLp5Y0QUoDWL7wXZYro33aLH
 60vA5o27NnFcBeJUplon8qjYKbU3ispYFW77oBhVigci7Y19qa
 h+RReLxKxbFfmih1RT+IA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219017>

Am 23.03.2013 17:28, schrieb Ilya Kulakov:
> The `git submodule` commands seem to ignore modules which paths conta=
in
> unicode characters.
>=20
> Consider the following steps to reproduce the problem:
>=20
>   1. Create a directory with name that contains at least one unicode =
character
>      (e.g. "=C3=BB=C3=B1=C3=AF=C3=A7=C3=B6d=C3=A9-r=C3=A8p=C3=B8")
>=20
>   2. Initialize git repository within this directory
>=20
>   3. Add this repository as a submodule to another repository so that
>      unicode characters will appear in the path to the module
>      (e.g. "../=C3=BB=C3=B1=C3=AF=C3=A7=C3=B6d=C3=A9-r=C3=A8p=C3=B8")
>=20
>   4. Check that .gitmodules file is updated and contains record
>      about just added module
>=20
>   5. List submodules with using `git submodule` and find out
>      that just added module is not listed

Thanks for your report. It is known that git submodule does not behave
very well when path names contain special characters. I'll look into
that when I find some time to see if we can easily fix your problem.
