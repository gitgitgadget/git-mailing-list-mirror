From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/4] format-patch: use a string_list for headers
Date: Sun, 7 Mar 2010 22:44:14 +0100
Message-ID: <40aa078e1003071344h5ef4358aif7888afdad1b4fc6@mail.gmail.com>
References: <7vk4torn8j.fsf@alter.siamese.dyndns.org>
	 <1267997598-20815-3-git-send-email-bebarino@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 22:44:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoOGt-0002sl-Ol
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 22:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab0CGVoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 16:44:17 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:39736 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab0CGVoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 16:44:16 -0500
Received: by wwa36 with SMTP id 36so2961356wwa.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 13:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Fi5Iw3vs7kEkLVRyBuZpwdtgi5k3ajd9cJZ88oc7ql0=;
        b=L1v0LEnzpK1mXKaaETHx9+f4pVCwLMFsaB3ShmEII09NqxVsAigmKEYpV46YkZrEn2
         VFdPjUAehIWdXv+UEXKcZ/XbOQSk28EC3gqZs+V+2JEhnNCF5UtI5Ni3jRePXy9mLASH
         aoPo0WmrcK8AqfxMO3k2D/c0P895o1msOv2oU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=HC5qS/QFaNoz/oVGz6Ve6bhyhr5wElvj8DQDEzOodg8awtDk72HP3A5wOziX/rsaws
         NLPzZ0aIZNs8WnKQ3j0yVT0f4kwA3OXW5W2g2nItf+F+Lp+FRQZuWGrOgcZhj+rfmfvc
         gbhAMYFdYvFGbLGczNYOxJM8z9/lUZ98HHM1Y=
Received: by 10.216.88.12 with SMTP id z12mr2195363wee.165.1267998254541; Sun, 
	07 Mar 2010 13:44:14 -0800 (PST)
In-Reply-To: <1267997598-20815-3-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141737>

On Sun, Mar 7, 2010 at 10:33 PM, Stephen Boyd <bebarino@gmail.com> wrote:
> +static struct string_list extra_hdr = { .strdup_strings = 1 };
> +static struct string_list extra_to = { .strdup_strings = 1 };
> +static struct string_list extra_cc = { .strdup_strings = 1 };
>

Do we really use this C99 feature (designated initializers)? I think
it will break MSVC builds, at least... Perhaps some other non-gcc
platforms as well?

-- 
Erik "kusma" Faye-Lund
