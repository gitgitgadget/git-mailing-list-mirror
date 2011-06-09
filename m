From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 17/19] transport-helper: export is no longer always the
 last command
Date: Thu, 9 Jun 2011 08:48:27 +0200
Message-ID: <BANLkTim1R=1SrUXgOOjmRioG45KKVity3Q@mail.gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-18-git-send-email-srabbelier@gmail.com> <7vsjrjzubl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 08:49:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUZ3J-0007bM-VN
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 08:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab1FIGtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 02:49:10 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46444 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab1FIGtI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 02:49:08 -0400
Received: by qwk3 with SMTP id 3so568873qwk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 23:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=qdnT2wl/+fL3/5Za8V8+H/5jRsbMccHzPO39IZE8iws=;
        b=VeVfAgXdcOUbWFD/MR5tC+xOv4m6v5DiURh4XbL3EonpttZpD10P1draMQcE9WaZEc
         OnAjBw6b/9BLXlEB9SgOHBiHi40ki6WBWS7wxOBf8JmN5PrzJD6T68UHNfRwm2v2O1U8
         h0EAOWBdnJRPzoOQxcpZVcMQNJLxXTzSbV9oI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=K2vX1kf4hRMwtH2kH1NN7xSmgxPVoFuSq628VMcXVaSoJISpYzTI0hJDkxBZNIwzW5
         8F+OiBBqTd9rPRQEzRZDrNsp/bLg1ANTUAoT9FN2bQVajnCDRzgtM5n3dnQnZhh7SZxS
         GRYW7af77dukI7ivBnXzexXyAvcKmmfbQ/I1o=
Received: by 10.229.135.12 with SMTP id l12mr269058qct.53.1307602147348; Wed,
 08 Jun 2011 23:49:07 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Wed, 8 Jun 2011 23:48:27 -0700 (PDT)
In-Reply-To: <7vsjrjzubl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175494>

Heya,

On Thu, Jun 9, 2011 at 03:07, Junio C Hamano <gitster@pobox.com> wrote:
> Could you clarify the logic, perhaps by commenting a bit more where this
> field is examined and code changes its behaviour in disconnect_helper()?

Previously this bit had to be set, so that we didn't try to write the
trailing \n on a closed socket. Now, the socket is no longer closed,
so we can send the trailing \n again. Does that make sense?

-- 
Cheers,

Sverre Rabbelier
