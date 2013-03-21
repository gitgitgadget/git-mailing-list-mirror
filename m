From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/4] drop some "int x = x" hacks to silence gcc warnings
Date: Thu, 21 Mar 2013 14:02:35 -0700
Message-ID: <20130321210235.GN29311@google.com>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <514AF2E1.7020409@viscovery.net>
 <20130321115545.GB21319@sigill.intra.peff.net>
 <7vppysbxzo.fsf@alter.siamese.dyndns.org>
 <7vhak4bx0w.fsf@alter.siamese.dyndns.org>
 <20130321154402.GA25907@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 21 22:03:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UImeO-0003SC-SB
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 22:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab3CUVDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 17:03:24 -0400
Received: from mail-da0-f42.google.com ([209.85.210.42]:60661 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab3CUVCk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 17:02:40 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so1858120dad.29
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 14:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=P6gWnd/G9OEI53k6EPEnyhC+QL5Fhd3IjInPNubFBPE=;
        b=InkHq5iLA8ojFKdr9spdP6krN8gxAL4+ybQAajqmPfCdKOTszZan1HRuX0MpArgtSb
         P7vmmntbPnTEDdrm0qIYrNUijSeFjxhEmxz03TMhHN0UrqVcRkbpkpce42ux9upLr4AT
         d/K/0gM5dmqjYP9e/5PC/RuIecV4F/8EEussGf4deMPZjEnFhHZn98BRd5BbXBt0K+DD
         GjqxE2sknob0bzIkPKp8F1qrswwzOv8bGcjW/63z613DUn9HQQL08807ef3IOi/P/AFP
         IDiNw+1kFQNPzh7V3kq2tjt0WJGI5og8+9YrksIX+vYtS24Xl8/BSnLse/ZDHd28MENt
         ltHQ==
X-Received: by 10.68.233.229 with SMTP id tz5mr16650364pbc.172.1363899760461;
        Thu, 21 Mar 2013 14:02:40 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id 1sm7301892pbg.18.2013.03.21.14.02.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 14:02:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130321154402.GA25907@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218761>

Jeff King wrote:

> Two patches to follow.
>
>   [5/4]: fast-import: clarify "inline" logic in file_change_m

This one is clearly a bug / missing feature in gcc's control flow
analysis, but your workaround looks reasonable.

>   [6/4]: run-command: always set failed_errno in start_command

Very sane.  Thanks.
