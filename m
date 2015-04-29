From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 14:24:30 -0700
Organization: Twitter
Message-ID: <1430342670.14907.11.camel@ubuntu>
References: <1430341032.14907.9.camel@ubuntu>
	 <20150429211615.GR5467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:24:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZTC-00030K-Jl
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbbD2VYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:24:34 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33831 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbD2VYd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:24:33 -0400
Received: by pacyx8 with SMTP id yx8so38981687pac.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 14:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=2htISlaaELS0sBxL2vqvGWGG6x/99v+lriWQTRWnzWQ=;
        b=EtgIBIbnm5Eavv9P0m2EYtvrNMCLXtAWQroUKeENQwP0IG6akBQxVI+V9e70YrgtKb
         Fcy3b/VLKLLwUHPln023qdwIXelzl5/dOdhnxObfe6qxwM8BSDD7H9qC7yAcIRM/PqnP
         wUxaC6iooRFZDP0eJaowk1vBeX0ScXTGjVPJS7mG/p/1HrKDM+8o6BewcK2NceTLatU4
         nJvOfu2W2aupuGXq8Xrx5f8wWCoMnzSWR/ulzq8n9/fbKYITiLophp0sgkSo80X8Ha9p
         btdYAx95jRwJbqUeMqvPQ6My/x0oJWk+xA2IpQudIR4L0vd3O89vmceFLY5NC4upLxmy
         1Zxg==
X-Gm-Message-State: ALoCoQl8V4ZFguBD3c5Sn4FbiQyzboyHtD4F1T0vh1w5J0MYOylmG8RjAI9Ot34foGfOCQ9mMuci
X-Received: by 10.68.245.67 with SMTP id xm3mr1863505pbc.45.1430342673327;
        Wed, 29 Apr 2015 14:24:33 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id fe10sm125932pdb.59.2015.04.29.14.24.31
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2015 14:24:32 -0700 (PDT)
In-Reply-To: <20150429211615.GR5467@google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268007>

On Wed, 2015-04-29 at 14:16 -0700, Jonathan Nieder wrote:
> Hi,
> 
> David Turner wrote:
> 
> > Instead, it would be cool if cat-file had a mode in which it would
> > follow symlinks.
> 
> Makes sense.
> 
> > The major wrinkle is that symlinks can point outside the repository --
> > either because they are absolute paths, or because they are relative
> > paths with enough ../ in them.  For this case, I propose that
> > --follow-symlinks should output [sha] "symlink" [target] instead of the
> > usual [sha] "blob" [bytes].
> 
> What happens when the symlink payload contains a newline?

Oh, right.
So, how about [sha] "symlink" [bytes] "\n" [target] instead?
