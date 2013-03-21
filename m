From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] wt-status: fix possible use of uninitialized variable
Date: Thu, 21 Mar 2013 12:58:04 -0700
Message-ID: <20130321195804.GI29311@google.com>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <20130321110527.GA18819@sigill.intra.peff.net>
 <20130321194949.GG29311@google.com>
 <7vip4ka5pb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 20:58:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIldG-0003cs-D8
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 20:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459Ab3CUT6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 15:58:10 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:44053 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab3CUT6J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 15:58:09 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so315656dae.23
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 12:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OcJd/edyb7M79qUI9RTiuZ/RL1mDodH6woANTk5Lxek=;
        b=gjsjIO0yYLL5sDj9p5S0jhehP+ZkA0LGsyfJkk3gr7bnrnYxK4QwjGqIpPGNswa0BR
         NMDORGSH13BLENqx8JBuRPWOB/zREU1USkp2ByLLThBx0OvFsqUibjKoyhSk4EFdFw8U
         YUc8xzq5At65iJyEf4uh+4vxx02vXGTlEpoGHuA6lFUk9psecf2uOQq8pIoHGaP47f2y
         0mHmGB6ClJuY4KLTplwtMTQtMQqRk1RrX8/pKkI9O94sQO0tqRY5ykaTj17sg1ryt2eD
         NaogoOyzs7wArEkOPVq2mIOAxnYF/LfJil7vrxG6OeicAXKB2vhW1lU9TpE2Ov2cC8pg
         VkUA==
X-Received: by 10.66.76.135 with SMTP id k7mr16298334paw.180.1363895889070;
        Thu, 21 Mar 2013 12:58:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ax3sm7139800pbd.42.2013.03.21.12.58.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 12:58:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vip4ka5pb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218753>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Jeff King wrote:

>>> +	default:
>>> +		die("BUG: unhandled change_type %d in wt_status_print_change_data",
>>> +		    change_type);
>>
>> Micronit: s/unhandled/invalid/.
>
> I actually think "unhandled" is more correct for this one; we may
> add new change_type later in the caller, and we do not want to
> forget to add a new case arm that handles the new value.

Ok.  Makes sense.
