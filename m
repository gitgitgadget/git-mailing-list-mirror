From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] get_sha1: support ref^{/regex} syntax
Date: Sun, 12 Dec 2010 22:40:31 -0600
Message-ID: <20101213044031.GA20812@burratino>
References: <1292209275-17451-1-git-send-email-pclouds@gmail.com>
 <1292209275-17451-3-git-send-email-pclouds@gmail.com>
 <AANLkTik2M=PPCXqtepRhntVYofrA0PUgzBLvdMNeeP5P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 05:44:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS0GY-0001L7-4S
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 05:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202Ab0LMEkk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Dec 2010 23:40:40 -0500
Received: from mail-gx0-f194.google.com ([209.85.161.194]:58918 "EHLO
	mail-gx0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755020Ab0LMEkk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Dec 2010 23:40:40 -0500
Received: by gxk1 with SMTP id 1so1885650gxk.1
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 20:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=w6R4gnE3bFbVJyYL+BbIUiZGDUeTx/L6neNuQf5eeE0=;
        b=NiOSZZ+jd3R6MGxsYyaVu8Eh9b1JIR2SDsIGfztWfFsZmWEEwxQxwGy0G0cNy4/X6s
         Z+iTwOsVX9Qhc/YfapVhVUtdtH3xnzGyHigIHxGa7i/R1Sot+eFE+PpvAmzBEQ5JMJr0
         qvSv4uIAGqbQgjw1EYmLlKCDosyVf8Pt48+20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=SkU7SUplfqZs0M8g5X3pyXbQPSSnQKkSA7yFlk1Qj0LMEN36PxJMnkh2g8EU3Wn+Gc
         U0rVj+yUDS/1+uHhosE+qMYnwQOBMfwuVTE77FwmpC5tzI8sDt2RHMoOYNF+OWXIKsDe
         Qv0Io35e5vwyq138J/CLry/1QvWZroPy03wAo=
Received: by 10.101.124.20 with SMTP id b20mr2313735ann.128.1292215238350;
        Sun, 12 Dec 2010 20:40:38 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.sbcglobal.net [69.209.48.248])
        by mx.google.com with ESMTPS id e24sm6883247ana.2.2010.12.12.20.40.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 20:40:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTik2M=PPCXqtepRhntVYofrA0PUgzBLvdMNeeP5P@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163513>

Nguyen Thai Ngoc Duy wrote:
> 2010/12/13 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>:

>> This works like :/ syntax, but only limited to one ref.
>
> Argh.. I read Jonthan's comment too late. Maybe "limited to one commi=
t
> tip (of a DAG)"?

As long as it doesn't filter into the documentation, I don't really
mind. :)
