From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] transport-helper: remove duplicate free()
Date: Thu, 3 Dec 2009 07:00:08 +0800
Message-ID: <be6fef0d0912021500w313ac170m65251f7b8a4fa1de@mail.gmail.com>
References: <20091202153950.c18095b7.rctay89@gmail.com>
	 <alpine.LNX.2.00.0912021120440.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Dec 03 00:00:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFyBH-0004UH-UV
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 00:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbZLBXAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 18:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754856AbZLBXAE
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 18:00:04 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:46130 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850AbZLBXAC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 18:00:02 -0500
Received: by iwn1 with SMTP id 1so491289iwn.33
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 15:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=u1YB5Nal5YC9qQ1FI1wd0Xk7MviMMib9n4tCvkXByGo=;
        b=yE87ycJEl4wAl40dIuX5nZx4FkbQRRv8Y41PZM/Fbui3WlAwgETuPomWHIw2a66zdr
         8WRbBZ0mEIeEfC+ieMLYl55iIOXy9ss33Sxm0h7VSuatc7q94Ldx9iYQil9lvTM9V6IH
         S9OMh1amc4omRoHZRBrz8qhXwgqGprLb4rRLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=QvIID1Nqnj0W12kyrjRzv0ZsERp/gl4atq+emWK2nkGFKaUl3WxRONADqf3VX4/AfV
         c5/hUCFkBidwqhrB+FekFbRt8MKaOknrfdq1ym1f/ibGNOB+V2hEuOdWU9uPyQdfvwtu
         OmcKugFlD+6tUEsIBzp0dzFfpkj2MI8sjp7+k=
Received: by 10.231.167.65 with SMTP id p1mr1356079iby.20.1259794808651; Wed, 
	02 Dec 2009 15:00:08 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0912021120440.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134416>

Hi,

On Thu, Dec 3, 2009 at 12:23 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> You need to remove the one in disconnect_helper, because the entire point
> of disconnect_helper as opposed to release_helper is to *not* free that
> memory. If you remove this one, you'll access freed memory in any case
> where the helper has to be quit and restarted.

I see. I guess I should have looked more closely at f2a3715 (Fix
memory leak in helper method for disconnect).

-- 
Cheers,
Ray Chuan
