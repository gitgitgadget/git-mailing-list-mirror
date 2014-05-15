From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 15/44] commit.c: use ref transactions for updates
Date: Thu, 15 May 2014 14:21:30 -0700
Message-ID: <20140515212130.GM26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-16-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 23:21:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl35u-0003CV-EO
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 23:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbaEOVVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 17:21:34 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:55021 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbaEOVVd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 17:21:33 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp16so1604348pbb.34
        for <git@vger.kernel.org>; Thu, 15 May 2014 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UjXp4ngWXa+/tcLF5yMgJ/+gtgkHTgUxWaHRN8O8M7M=;
        b=gS0Xzr4BJuqJJkLqR1ihu/7vuyqHvYKbqUbQyreGFacsfHImfgHUh2d8NHlWlI98nS
         cz16jTBVk+rafPrmjUM9b06z3j9bpWCA/UM9QWc594c0TufhR5czKObjt4mAhQic4tGg
         uVS3cYQnAsKuMpbcNdUTJihdr2qcZkpGgz+usQUqL/NeqGtpiOGhwx+GsWxJUHlmmh4D
         GrFZS/3ArH+ja97jTURxltTpHvUCnoiHnbW4cR2oV0PN+2S7rMvVK4cxM3sz6kdBcFS+
         kn+ajL/kqfHbirIbjiyOpnb4pmuiuCHyp220LcJTT8gLaZ/RR+X4qJxFh2iSUO/xpFxp
         c31g==
X-Received: by 10.68.218.3 with SMTP id pc3mr15265090pbc.71.1400188892713;
        Thu, 15 May 2014 14:21:32 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id it4sm10767058pbc.39.2014.05.15.14.21.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 14:21:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-16-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249203>

Ronnie Sahlberg wrote:

> Change commit.c to use ref transactions for all ref updates.
> Make sure we pass a NULL pointer to ref_transaction_update if have_old
> is false.

Once ref_transaction_begin() and ref_transaction_update() set err,
this will always have a reasonable message to print in die().

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
