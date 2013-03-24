From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] checkout: avoid unncessary match_pathspec calls
Date: Sat, 23 Mar 2013 22:45:05 -0400
Message-ID: <CAPig+cR3=h6gCTC223mOrS3dQWt8dv49BDHj52W27ZoV6HvJkA@mail.gmail.com>
References: <1364036142-3031-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 03:45:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJawI-00031v-6C
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 03:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709Ab3CXCpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Mar 2013 22:45:09 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:37742 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab3CXCpI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Mar 2013 22:45:08 -0400
Received: by mail-la0-f49.google.com with SMTP id fs13so9316658lab.22
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 19:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uwm7mfDtb0hjatZMzQtUj8U6gl67+zFIcvfwSloWSRM=;
        b=Q6rDr62OpmRiqVdYMsl/Pyz8tbU0juAYPfUJ8YZG4xRw+urmqGRB+9SyLu+fCgE28H
         JoxdNsPsWDrZiUoaqVnYNsAj4lfmVwiqKmKGEZar/lh+8SHW2zZV0u+04LEfXgA+0Dde
         idx936/meu2vvv5GuUfWWDdNa8HUiYMVJ4R8grGxOajPuchphUODAvjYIuGBDmy+mmYW
         9deKWrq1DngvwehwoM0goA3y1HIs3/prBlAwLnPOFLNvDWJGuKtUU1g2B6K0EawaEPqR
         ebiKeOd5DxLLrq2hzJCZEJHYePK0Pgovw/Lu7J3glq8Q21vSxafhyPcYzpahIICV+Yyq
         ftHw==
X-Received: by 10.152.47.242 with SMTP id g18mr3535919lan.42.1364093105841;
 Sat, 23 Mar 2013 19:45:05 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Sat, 23 Mar 2013 19:45:05 -0700 (PDT)
In-Reply-To: <1364036142-3031-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: u3t1qDxS44JaFaPEYlNAZT17TdE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218929>

On Sat, Mar 23, 2013 at 6:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> checkout: avoid unncessary match_pathspec calls

s/unncessary/unnecessary/

> In checkout_paths() we do this
> ...
