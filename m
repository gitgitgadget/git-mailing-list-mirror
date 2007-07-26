From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH] fully resolve symlinks when creating lockfiles
Date: Thu, 26 Jul 2007 15:34:50 -0400
Message-ID: <118833cc0707261234u59e30bchc274ae29569d8500@mail.gmail.com>
References: <7vbqe0cazy.fsf@assigned-by-dhcp.cox.net>
	 <11854712542350-git-send-email-bradford.carl.smith@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bradford C. Smith" <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 21:35:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE96x-00024B-0z
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 21:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763972AbXGZTez (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 15:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763585AbXGZTez
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 15:34:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:59388 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763404AbXGZTey (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 15:34:54 -0400
Received: by wr-out-0506.google.com with SMTP id i30so395472wra
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 12:34:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ev6bfZ9l/IHR/jnpAI/lL/tHrhwbR3NcZx/1PNNB6P3mhWvADFrWv756Fkl9FKnXkuM0CJND4B2VXxLq6GCqrbX3ZxeAfymQIyqOrExNuamUlDJpThK78kki4QTp62pHhS2SMUC9c/ijXOZsAwDljTMym8WbAliIbmST1NssR5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LuVbJOQkfyX57H8Z1OtLbeMXL/1vxo6dsBHWX0pgBQvRhyhuEfrB5KAeHlsrwnBhQuGL2Wx9Z6fxRwAOpweJHOiLDu+6QkbpDNEVpd5+b1KCr6XRcKuhjYFu9u9dWOBCPjRpRmerM/pgEDmaVCrQAmQ99k8fUa6vk9UbbySyLlM=
Received: by 10.78.157.19 with SMTP id f19mr521649hue.1185478490678;
        Thu, 26 Jul 2007 12:34:50 -0700 (PDT)
Received: by 10.78.141.20 with HTTP; Thu, 26 Jul 2007 12:34:50 -0700 (PDT)
In-Reply-To: <11854712542350-git-send-email-bradford.carl.smith@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53860>

Why the lstat and that stat in the beginning?  That's just asking for race
condition.  readlink will tell you if it wasn't a link, for example.

Morten
