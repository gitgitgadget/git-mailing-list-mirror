From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 04/45] pathspec: add copy_pathspec
Date: Sun, 9 Jun 2013 03:58:00 -0400
Message-ID: <CAPig+cTP8HuPzp=THuSTFtRW8uNgqxROWuQUG7_bYC_FSs5rpQ@mail.gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
	<1370759178-1709-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 09:58:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlaVs-0006EY-Ll
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 09:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab3FIH6D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 03:58:03 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35903 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab3FIH6C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 03:58:02 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so2677870lbi.26
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 00:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZKEk0ETrLH4xV1IZrJKCRiJBPPJIYd/U3vdV+5xF6oM=;
        b=A+VFbzDmDnKY0MA7nEfHFE/58LDQ2+c7HZ0VoZikyFp0Y0PVusIzl9oLd9E3LXAa7i
         a8PYkCq4UeBA+5WatVyUfvAGslI5zUzTXfSjPpPKXOEAHgxXDWLmfRHo8A3/8G/r3Pjq
         nVbqTV7dUdVEBjveqhhscFCwuHE/RlNzJYMlpTN5oQp0VXowhJ6rnyDBTqNpIjSo2Oqj
         sd7Wubqf6/WTMy2MuUy6V1IOdQIpo1nueK7srTF3wMhzO13EGJRxaUmv8jhVtXquskMW
         YGZDT4ovbp1zryEBp8NYlnMNZOgrxsq7qLlD0oTdIfxq7bPFg7Xcr4BO9tnboIdNE7yj
         g05A==
X-Received: by 10.152.44.225 with SMTP id h1mr2498530lam.90.1370764680778;
 Sun, 09 Jun 2013 00:58:00 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 00:58:00 -0700 (PDT)
In-Reply-To: <1370759178-1709-5-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: zneYJI0zNV_-cNgQEmR3O_sf6x0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226942>

On Sun, Jun 9, 2013 at 2:25 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> The function is made to use with free_pathspec() because a simple
> struct assignment is not enough (free_pathspec wants to free "items"
> pointer).

I had to read this about five or six times before I could parse and
understand it. Perhaps rewrite something like this:

    free_pathspec() frees pathspec->items, hence simple struct
    assignment does not properly duplicate a pathspec. Introduce
    copy_pathspec() to clone a pathspec correctly by deeply copying
    the items member.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
