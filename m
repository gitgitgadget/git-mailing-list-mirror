From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 01/21] path.c: avoid PATH_MAX as buffer size from get_pathname()
Date: Sun, 15 Dec 2013 16:02:33 +0700
Message-ID: <CACsJy8CVQfWdTY_aoH6uMTp0cgTnvF09tC7iLD7CjEL9d9=bzw@mail.gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com> <1387018507-21999-2-git-send-email-pclouds@gmail.com>
 <52AD69D4.30605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 15 10:03:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vs7c6-0004yk-WB
	for gcvg-git-2@plane.gmane.org; Sun, 15 Dec 2013 10:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab3LOJDJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Dec 2013 04:03:09 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:39668 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab3LOJDH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Dec 2013 04:03:07 -0500
Received: by mail-qa0-f45.google.com with SMTP id o15so753951qap.4
        for <git@vger.kernel.org>; Sun, 15 Dec 2013 01:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UA0TejIbJBQ3Xj9KNdN1ffJz5bgy1B02nTiydF4D30c=;
        b=xJRWFLJAym/Vgpi1VmlV40coipAt4P7J23p1+PaNfbGOKIgr3P5d0CyytJ3sTfwHPv
         wcqi5cpMvCrcDY72QphLX/zO/0hdlSd4ms7LK9lHLDJhEUQpeLDpYEwstHUqLHHa2rOQ
         zvP9csGfQAbIW6hCKSgN5cDD9vqDcX82hGx3G1FVxHSmO7HwGN0/0XAeXENLruUGMkI3
         E71XTpeHac/6RjAZHcHpe/8d+ElkzScwmgwPBKlhOHVpyUTi2/qEmQ2lWdy7ISQ/K0SN
         YT+5xYe7DoVkiVcq/lbejaWIMjaLN2kpJzarc57qCAwNgXXIosHtHNjH1ASk+EI6fDwA
         VUNw==
X-Received: by 10.224.24.194 with SMTP id w2mr10985415qab.48.1387098183545;
 Sun, 15 Dec 2013 01:03:03 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Sun, 15 Dec 2013 01:02:33 -0800 (PST)
In-Reply-To: <52AD69D4.30605@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239325>

On Sun, Dec 15, 2013 at 3:35 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> If we really want to go away from PATH_MAX, is a hard-coded value of =
4096 so attractive ?
> Because we can either
>
> a) Re-define PATH_MAX in git-compat-util.h
> b) Use an own  #define in git-compat-util.h, like e.g. GIT_PATH_MAX
> c) Change the code to use a "strbuf" which can grow on demand.
>
> I would prefer c) over b) over a)

Looking at the code again, c) looks feasible after updating
git_snpath() to accept a strbuf instead of buffer/size pair.
--=20
Duy
