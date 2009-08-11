From: skillzero@gmail.com
Subject: Re: [RFC PATCH v3 7/8] Support sparse checkout in unpack_trees() and 
	read-tree
Date: Tue, 11 Aug 2009 14:18:55 -0700
Message-ID: <2729632a0908111418m57e03d8as9c122cbb52efc21a@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-2-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-3-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-4-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-5-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-6-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-7-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 23:19:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaykR-0000nM-Fd
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 23:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbZHKVS5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 17:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbZHKVS4
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 17:18:56 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:54540 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754779AbZHKVSy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 17:18:54 -0400
Received: by qyk34 with SMTP id 34so3498622qyk.33
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2nWdXC7PWgbV4GSYiSx95q2+VYi5CZehNpn0HAwKlF0=;
        b=w5Rujw9eJZ4tk6enh6L5SBoLK7lQ75z0QiRv4yQ/u6K9ZOqS0B/91V+XC0CfWdCqEB
         3p8qrBtG72ZKsCOOsVLpOKxLnDqjVOU6UUeAtrVJ3xgQ4I0Zwhk+RN2X1omW1y0ll0ZF
         /uLW1OV9v13vpIN+0tvOrNQMwAFR/aIaWENbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=K5aiRVI7zAfX7A+paou4hc1UUmQpA0IjwvC+e6RmEVQ5ySEGslOtAoA5czfxV72kQy
         lpYz9PSjUWxb9mjiS8DuaV3Fct+c8Ma2J0nmcWAs9LchLS5jyDmetaqu33OntVZat24h
         WiVXjG4xeYhdlLZT9CqmLOWQk8L4gClcViy2Q=
Received: by 10.224.45.76 with SMTP id d12mr4466816qaf.131.1250025535635; Tue, 
	11 Aug 2009 14:18:55 -0700 (PDT)
In-Reply-To: <1250005446-12047-8-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125600>

2009/8/11 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> [1] .git/info/sparse has the same syntax as .git/info/exclude. Files
> that match the patterns will be set as CE_VALID.

Does this mean it will only support excluding paths you don't want
rather than letting you only include paths you do want?

I'm currently using your other patch series that lets you include or
exclude paths (via config variable) and I find that I mostly use the
include side of it with only a few excluded paths. This is because I
typically want to include only a small subset of the repository so
using excludes would require a pretty large list and any time somebody
adds new files, I'd have to update the exclude list.

I appreciate the flexibility of the script to control what is included
or excluded, but like some other comments here, I like the simplicity
of having built-in support for including/excluding paths without
having to write a script to do it. Some of my projects run on Windows
so scripting is more difficult there.
