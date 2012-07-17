From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix overwritten remote ref on with fast-import.
Date: Tue, 17 Jul 2012 08:48:20 -0500
Message-ID: <20120717134820.GE3071@burratino>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <11883284.WI8IR4K6qp@flobuntu>
 <20120717032725.GC3071@burratino>
 <1948960.GdZ6fLVixa@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 15:48:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr88d-0000v3-33
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 15:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226Ab2GQNs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 09:48:26 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41096 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab2GQNsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 09:48:25 -0400
Received: by yenl2 with SMTP id l2so375148yen.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 06:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=keqR6EAWDEYSenZNJqs2xAPMdwLfQVo69ChTNBaMoQY=;
        b=GGiLV3gByEwiZBO3DUFLl1KJXOS9NnPCr9f5sTC84/sGew3M97hG4lLUtnlNyhUCGD
         TKI621Ej6hmMX0pd7+zQcuzEbNB9qWg0ToVPB6GFKtWitlLfcnHTgwqBxto8hETBUMtQ
         Vhpx0lZJsYq7L3gwWZIABqbAFDdfHUDPsm6cUY2GxkgaD9XQT+OA1a6SvtAhmofUcKvp
         z25ZYe45nh2vWkfgRC96M5ifMXBMnRw8ZihS5eFlf9T08quqS1odS5yjv664Ca6FKGRS
         FD36lBf/wCBxsiu8e2kK/RPvVZhnFL0dU5aLqZuR/8Se96ZRVXF6MnPWiWb8lSHtPynj
         XNDA==
Received: by 10.50.173.69 with SMTP id bi5mr1373844igc.38.1342532904476;
        Tue, 17 Jul 2012 06:48:24 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id f8sm11795371ign.0.2012.07.17.06.48.23
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 06:48:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1948960.GdZ6fLVixa@flobuntu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201603>

Florian Achleitner wrote:
> On Monday 16 July 2012 22:27:25 Jonathan Nieder wrote:

>> Hm, that still doesn't look right.  The RHS of the refspec is supposed to
>> be a _private_ namespace for the remote helper, and refs/remotes/ is
>> not private.
[...]
> remote-svn now uses get_fetch_map to retrieve the local refs. So it respects 
> the fetch refspec in the config.

No no no no no.  That's transport-helper's job.

The RHS of the remote helper's refspec really is supposed to be
_private_.  Improvements to the documentation to clarify this would be
welcome.

Thanks,
Jonathan
