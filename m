From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] rebase: accept -<number> as another way of saying HEAD~<number>
Date: Sun, 2 Mar 2014 15:45:25 +0700
Message-ID: <CACsJy8DCpisoq698infq3X7Z1o8L_+zd1ai4-NCBXUpThvGcTQ@mail.gmail.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
 <1393728794-29566-1-git-send-email-pclouds@gmail.com> <1393728794-29566-3-git-send-email-pclouds@gmail.com>
 <CAPig+cTj1hBOFDLA5LecXwrVN4FG6pAzSDTAyLchHQbOkoEnEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 09:46:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK224-0001mA-Hz
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 09:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbaCBIp4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2014 03:45:56 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:40363 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbaCBIp4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 03:45:56 -0500
Received: by mail-qg0-f51.google.com with SMTP id q108so7750889qgd.10
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 00:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tiZG+JA2jiSh7SQ1Z6AdMz5iGCwR54t0eoGX83j/b+0=;
        b=y8AnCGELFpx7HXTCOzN6hidf5YzHAh6vQBDk2guYXD8zVXXEm7Vgks7F5HoMr3HxbT
         3tTTtGMcVdfs6pccJRVq/l664UxMftSaYNHcfaKlyO8Gj1QFqe7LjGRrpdaVeLFWYj0T
         ZSbNcbGejEYfKohjmYOjsoQ7rkoOmSZyIoxrImD5x54w+hLaQlKxI2w28We5Ymteo9uF
         T+LkB+ufHOyacSiFWj7L2n/Vyr/A2+RRq9PgVOVDnlgjotA3A6Q+uK7m6K5LDrSTnjvz
         4ULw1P4uavHg8N9DpAdZKqSmp0rP0QT86B7T4VOUNPTijpEzNID0/naixKQ8rdcvHYjA
         nivQ==
X-Received: by 10.140.40.5 with SMTP id w5mr15087148qgw.65.1393749955698; Sun,
 02 Mar 2014 00:45:55 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sun, 2 Mar 2014 00:45:25 -0800 (PST)
In-Reply-To: <CAPig+cTj1hBOFDLA5LecXwrVN4FG6pAzSDTAyLchHQbOkoEnEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243141>

On Sun, Mar 2, 2014 at 3:37 PM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Sat, Mar 1, 2014 at 9:53 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> This is "rev-list style", where people can do "git rev-list -3" in
>> addition to "git rev-list HEAD~3". A lot of commands are driven by t=
he
>> revision machinery and also accept this form. This addition to rebas=
e
>> is just for convenience.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/git-rebase.sh b/git-rebase.sh
>> index 5f6732b..33face1 100755
>> --- a/git-rebase.sh
>> +++ b/git-rebase.sh
>> @@ -342,6 +346,11 @@ do
>>         esac
>>         shift
>>  done
>> +if [ -n "$NUM" ]
>
> With the exception of one errant "if [...]", git-rebase.sh uniformly
> uses "if test ...".

Besides that and  three more "if [...]" in git-rebase--interactive.sh,
git-rebase*.sh uses "if test..." only. Will reroll with a cleanup
patch to make them all "if test.."
--=20
Duy
