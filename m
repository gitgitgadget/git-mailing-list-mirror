From: =?ISO-8859-1?Q?Beno=EEt_Legat?= <benoit.legat@gmail.com>
Subject: Bug with `git branch HEAD` in a 'detached HEAD' state
Date: Thu, 15 Aug 2013 22:50:50 +0200
Message-ID: <520D3F2A.5020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 15 22:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA4VX-0002Ad-MG
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 22:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911Ab3HOUu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Aug 2013 16:50:56 -0400
Received: from mail-ea0-f170.google.com ([209.85.215.170]:50945 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab3HOUuy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 16:50:54 -0400
Received: by mail-ea0-f170.google.com with SMTP id h14so610965eak.29
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 13:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=6vao17yU27C2liFL9UGcxXN2TWYPAOjkkDz0JwqoGB8=;
        b=zs38gal+9a9KO755nKTgicIPtWOyS/BO6COWLty1h7irz0OEJkSr54TSBNses1ZB68
         HBOj90u+0U1BjaSn5iwt64g6gRirH7GfDdAKyBzqJ3eEnEfXnr/f1UQUii6Ktz6kUHfN
         +gAQlONi+SCZch0ab+hFlfOmCfB4i6U9g0pZSbNn9Dp7k7Nwq9SqV2+FbIwSpNGrKcyC
         0c1+cdS4L7vkGEP19mhSZNqNQHlFd3xU8VsuMSoKmvWU/cVYSwfQOo+rfUSgQR2p2PCv
         q5Iy8HE42zgq8G6hDsdgfF3sC7p9c/5/nQwBD+n7yogW7SRIig2ugvpzvpoGbgWDjx3x
         vlCQ==
X-Received: by 10.14.251.10 with SMTP id a10mr24054ees.76.1376599853356;
        Thu, 15 Aug 2013 13:50:53 -0700 (PDT)
Received: from [192.168.1.4] ([91.178.161.95])
        by mx.google.com with ESMTPSA id f49sm1642305eec.7.2013.08.15.13.50.51
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 13:50:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232367>

Hello everyone,

I think I have just found a bug in Git which basically occurs when I ru=
n=20
`git log HEAD` in a detached HEAD state.
To reproduce it, just run
$ git init
=2E..
$ touch tmp
=2E..
$ git add tmp
$ git commit -m "tmp"
=2E..
$ git checkout <commit_sha>
=2E..
$ git branch HEAD
Segmentation fault (core dumped)

My version of git is the following
$ git --version
git version 1.8.1.2

If that helps (and even if it doesn't actually), I'm running ubuntu=20
13.04 64-bit.

Beno=EEt Legat
