From: David Barr <davidbarr@google.com>
Subject: Re: [PATCH v2] am: ignore leading whitespace before patch
Date: Mon, 8 Aug 2011 15:31:03 +1000
Message-ID: <CAFfmPPPpYDA39U9UYKojj90fST40voe=dgBi3QPjQdhBT89NmQ@mail.gmail.com>
References: <1312323646-93427-1-git-send-email-davidbarr@google.com>
	<20110808024904.GF19551@elie.gateway.2wire.net>
	<1312780242-91659-1-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Simon Sasburg <simon.sasburg@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 07:31:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqIQp-0005RB-Vn
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 07:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866Ab1HHFbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 01:31:12 -0400
Received: from smtp-out.google.com ([74.125.121.67]:23352 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab1HHFbH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 01:31:07 -0400
Received: from kpbe20.cbf.corp.google.com (kpbe20.cbf.corp.google.com [172.25.105.84])
	by smtp-out.google.com with ESMTP id p785V5uo025758
	for <git@vger.kernel.org>; Sun, 7 Aug 2011 22:31:05 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1312781466; bh=IZnRs7oKB/+y7UDNvcbECltKsi0=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	b=S3FW/CAqehF7EZs5FGslQLGpYa8ePW4lj3p66RVOutvT0Bc9AP0kayZMLZ0Ru8a4q
	 fYoMrBnOaaSsJVyEWIP4A==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=dkim-signature:mime-version:in-reply-to:references:date:
	message-id:subject:from:to:cc:content-type:
	content-transfer-encoding:x-system-of-record;
	b=TTtkmfeBpV1aJC3p28azKhf9/+IZPoPtnuzkf3Z95slZ/2trSxrhCj+W6GvOYkyyQ
	9EIxrOced7Tr7U4YLWYBQ==
Received: from gxk9 (gxk9.prod.google.com [10.202.11.9])
	by kpbe20.cbf.corp.google.com with ESMTP id p785V34F014479
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sun, 7 Aug 2011 22:31:04 -0700
Received: by gxk9 with SMTP id 9so2065996gxk.40
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 22:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=AV8sRUufs2fuFASrhqIJwLPemj4j6CP1K7M62im7E/8=;
        b=jDpBWOoQLJjFCkCnKE06Cv0zH4/xnc3aO/2SHJOeihtd4jtTZ+9RjoXS/oWzNZKM0w
         iBgBkCr4U5EUJpgZWXmg==
Received: by 10.100.60.3 with SMTP id i3mr4174965ana.113.1312781463377;
        Sun, 07 Aug 2011 22:31:03 -0700 (PDT)
Received: by 10.100.60.3 with SMTP id i3mr4174955ana.113.1312781463188; Sun,
 07 Aug 2011 22:31:03 -0700 (PDT)
Received: by 10.100.144.6 with HTTP; Sun, 7 Aug 2011 22:31:03 -0700 (PDT)
In-Reply-To: <1312780242-91659-1-git-send-email-davidbarr@google.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178942>

*facepalm*

This test already passes:
> + =A0 =A0 =A0 git am <patch1-ws.eml >output.out 2>&1 &&

Alternatively, the following was failing:
> + =A0 =A0 =A0 git am patch1-ws.eml >output.out 2>&1 &&

Note that the email file is passed as an argument rather than a redirec=
t.
--
David Barr
