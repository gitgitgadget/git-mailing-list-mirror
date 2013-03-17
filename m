From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 05/12] pretty: save commit encoding from logmsg_reencode
 if the caller needs it
Date: Sun, 17 Mar 2013 04:57:43 -0400
Message-ID: <CAPig+cQ52J=21Z5JVq2ifZKVAiDSHBYr=_Db7L6k+Lr2tLgHBQ@mail.gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
	<1363400683-14813-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 09:58:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH9Pw-0006EE-Ib
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 09:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194Ab3CQI5q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 04:57:46 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:49114 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140Ab3CQI5p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 04:57:45 -0400
Received: by mail-la0-f49.google.com with SMTP id fs13so4984651lab.22
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 01:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f8UWrLQgLdLGVZLeCbFFRUIvt7pDkp58gnbTdl41V1Y=;
        b=ssm85+9FoDqbWe62xGlob02cUrt1awfr83mb6XtXZxOQTp2uXDOmV3avEgH2HODmO7
         gJvOb7hCh9ALcbYuwuxjyCsiyGAAix6+dgQA8veJs7tT9C4kGqMtJTCUEIQeErLU25kW
         ZhPpONgyrPVJOWsnxDmDaDTOv0UilarVdDq+rt3qTFJY1AnX5e5rvlyOOCYf5O9zBPgr
         nvLgPuFMSdlaPI+ao5VifG9IjBkx4wuVQxAy+roNIpU9OfHei+TOe0487RXfluqNy/Gf
         HeCFvLAu68/kyXDTJYlh9GzUR26nA3NC4wJ2IAlWM4iTQI31WJO9v/XCOj89PNIzSjb6
         gW2A==
X-Received: by 10.112.88.35 with SMTP id bd3mr4915068lbb.56.1363510663863;
 Sun, 17 Mar 2013 01:57:43 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Sun, 17 Mar 2013 01:57:43 -0700 (PDT)
In-Reply-To: <1363400683-14813-6-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: iM91rZwhB4OwFNboWouwOKORqPs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218355>

On Fri, Mar 15, 2013 at 10:24 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> The commit encoding is parsed by logmsg_reencode, there's no need for
> the caller to re-parse it again. The reencoded message now have the

s/have/has/

> new encoding, not the original one. The caller would need to read
> commit object again before parsing.
