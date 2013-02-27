From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 1/4] config: factor out config file stack management
Date: Wed, 27 Feb 2013 08:56:28 +0100
Message-ID: <20130227075627.GB4685@sandbox-ub>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
 <7v4nh13plo.fsf@alter.siamese.dyndns.org>
 <20130226193050.GA22756@sandbox-ub>
 <20130226193850.GB22756@sandbox-ub>
 <20130226195449.GA13830@sigill.intra.peff.net>
 <20130226200940.GF22756@sandbox-ub>
 <7vk3pulo6w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 08:57:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAbsq-0007JA-7C
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 08:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab3B0H4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 02:56:35 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:49387 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab3B0H4f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 02:56:35 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UAbsK-0002Kj-Kh; Wed, 27 Feb 2013 08:56:28 +0100
Content-Disposition: inline
In-Reply-To: <7vk3pulo6w.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217199>

On Tue, Feb 26, 2013 at 02:12:23PM -0800, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > The "do_config_from" means "parse from whatever is in 'top'". Later in
> > the series its type changes from config_file to struct config.
> 
> Yuck.  It would be nice to have it as struct config_src or
> something. "struct config" sounds as if it represents the entire
> configuration state and you can ask it to add new ones or enumerate
> all known configuration variables, etc.

Will change it to struct config_source. I choose that name in lack of a
better one. Since it can be considered the base for both sources I just
removed the _file postfix.

Cheers Heiko
