From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 20/24] update-index: test the system before enabling
 untracked cache
Date: Wed, 21 Jan 2015 16:46:30 +0700
Message-ID: <CACsJy8CDgUWEE=QKAgw4G8pgA-cOmLMs4sH67C47Ohd5XJQDNQ@mail.gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
 <1421759013-8494-21-git-send-email-pclouds@gmail.com> <xmqqwq4gy1nq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 10:47:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDrsS-0006IJ-9z
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 10:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbbAUJrE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2015 04:47:04 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:56142 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbbAUJrB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2015 04:47:01 -0500
Received: by mail-qc0-f177.google.com with SMTP id p6so10051553qcv.8
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 01:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rk0FW6Dg2p0J2+9QZAb2uEtkEa9WxyvzJbFytd7Gu4M=;
        b=G/j9N6ZyiL4AHjmVwSyhrdfepVJqs199LO8j2mCJaMaHVPs3VjwemdmAHp7mWCuYKZ
         GRX1BTIbBGfXIgpZTXlDpzKABbDBkgu5A01X2pbz+qspxFIxY8QDtC9/lh2/2OfJKjwF
         FTKkTIdaH/G1tbrL6o644DSjvM+/7r8NFyrUItCgF6V8jNnJM9yb73ApwDDxb/dC6Mth
         mvz1KyIOaojyXVA92hBSVf9TuDfP+UO9DYCWwEktVgh8dPCtqEGdbQXIxAqKVFiEKk63
         Nw40AhuToRm91dy8L8W8xUUXy5TTmMWlcj69ul3mb9sfWLEJIaeJwH68XJnS1FHGuJFD
         4fxg==
X-Received: by 10.224.127.193 with SMTP id h1mr52899671qas.98.1421833620500;
 Wed, 21 Jan 2015 01:47:00 -0800 (PST)
Received: by 10.96.137.73 with HTTP; Wed, 21 Jan 2015 01:46:30 -0800 (PST)
In-Reply-To: <xmqqwq4gy1nq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262728>

On Wed, Jan 21, 2015 at 3:32 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>
> It appears that this hijacks a fixed name dir-mtime-test at the root
> level of every project managed by Git.  Is that intended?

I did think about filename clash, but I chose a fixed name anyway for
simplicity, otherwise we would need to reconstruct paths
"dir-mtime-test/..." in many places.

> Shouldn't --use-untracked-cache option require the working tree
> (i.e. die in a bare repository)?

setup_work_tree() takes care of that

> ~/w/git $ git init --bare foo
Kh=E1=BB=9Fi t=E1=BA=A1o tr=E1=BB=91ng r=E1=BB=97ng kho Git trong /home=
/pclouds/w/git/foo/
> ~/w/git $ cd foo/
> ~/w/git/foo $ ../git update-index --untracked-cache
fatal: This operation must be run in a work tree
--=20
Duy
