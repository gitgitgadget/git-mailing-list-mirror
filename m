From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 0/2] thin-pack capability for send-pack/receive-pack
Date: Wed, 06 Nov 2013 22:41:22 +0100
Message-ID: <1383774082.2850.10.camel@centaur.cmartin.tk>
References: <1383750263-32495-1-git-send-email-cmn@elego.de>
	 <xmqqbo1x8e60.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 06 22:41:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeAr1-00074C-Ns
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 22:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab3KFVlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 16:41:31 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:40051 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524Ab3KFVla (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 16:41:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id DB0A9DE077;
	Wed,  6 Nov 2013 22:41:28 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9lVgmfEZ5O6j; Wed,  6 Nov 2013 22:41:28 +0100 (CET)
Received: from [192.168.1.4] (p57A1FC45.dip0.t-ipconnect.de [87.161.252.69])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 9C180DE075;
	Wed,  6 Nov 2013 22:41:28 +0100 (CET)
In-Reply-To: <xmqqbo1x8e60.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.8.5-2+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237371>

On Wed, 2013-11-06 at 12:32 -0800, Junio C Hamano wrote:
> I'll queue these for now, but I doubt the wisdom of this series,
> given that the ship has already sailed long time ago.
> 
> Currently, no third-party implementation of a receiving end can
> accept thin push, because "thin push" is not a capability that needs
> to be checked by the current clients.  People will have to wait
> until the clients with 2/2 patch are widely deployed before starting
> to use such a receiving end that is incapable of "thin push".
> 
> Wouldn't the world be a better place if instead they used that time
> waiting to help such a third-party receiving end to implement "thin
> push" support?
> 

Support in the code isn't always enough. The particular case that
brought this on is one where the index-pack implementation can deal with
thin packs just fine.

This particular service takes the pack which the client sent and does
post-processing on it to store it elsewhere. During the receive-pack
equivalent, there is no git object db that it can query for the missing
base objects. I realise this is pretty a unusual situation.

Cheers,
   cmn
