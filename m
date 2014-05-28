From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 10/41] update-ref.c: log transaction error from the
 update_ref
Date: Tue, 27 May 2014 17:27:38 -0700
Message-ID: <20140528002738.GJ12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-11-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 02:30:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpRl7-00079k-6R
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 02:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694AbaE1AaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 20:30:15 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:51966 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981AbaE1A1l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 20:27:41 -0400
Received: by mail-pb0-f50.google.com with SMTP id ma3so10157132pbc.37
        for <git@vger.kernel.org>; Tue, 27 May 2014 17:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qO7gOqgg6UPdNWoC+L+38b4mHHvei9K9zGGQ9zi3wEI=;
        b=ZbUff3BtpeKeqbBqDFOQ280EsA7LRt8XoMhht7txKWzlcJFtb/FQx8HpU+qfZFJSev
         DBDPKTrUu/BsPOp+lBGNMrZrIfTMW1bTorI9sHEkDysWO8L58RJqnMijV5gyv1Km0DGK
         M4osyVV89U2Ru7AUZtT5fgeY1i1q7KbjMb6DV+M2Y97irmJr0i5AsufloQVydKhEMF5a
         KUM5mLu5otL10YuDYoQK7raLW/zp267WZjbVhly9zDB4FGjlBnBp6RC5EQhUucpIjBoL
         AH9wEPyRODN7d0HajMdcoWbNbMNj60eTmpdzQTEAFvh6D0OLwiW7rQ9nNsqmhFSgvVlE
         QHCw==
X-Received: by 10.67.15.40 with SMTP id fl8mr27701651pad.69.1401236861389;
        Tue, 27 May 2014 17:27:41 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id fv2sm225014pbd.11.2014.05.27.17.27.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 17:27:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-11-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250252>

Hi,

Comments from http://marc.info/?l=git&m=140079653930751&w=2:

Ronnie Sahlberg wrote:

> [Subject: update-ref.c: log transaction error from the update_ref]

The above description suggests that this is going to add new logging,
or in other words that update_ref was being silent about transaction
errors before.

The actual intent is for there to be no functional change, right?  I'd
say something like "update-ref: use err argument to get error from
ref_transaction_commit" or something similar to make it clearer that
this is just about changing APIs.  Or if there's an intended
functional change, then the commit message could say something about
that.

Thanks,
Jonathan
