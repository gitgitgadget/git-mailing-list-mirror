Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1063420189
	for <e@80x24.org>; Wed, 22 Jun 2016 15:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbcFVPel (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 11:34:41 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33627 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbcFVPeh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 11:34:37 -0400
Received: by mail-lf0-f51.google.com with SMTP id f6so76616229lfg.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 08:33:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qdv+aFAG4ZkTSPXQe/Y2CwqFsr/7AebTPDZjO3hggCI=;
        b=AvG9DuOiUtr6naRJUXzJjbE8GdrN8PvoQ44vtY4QglVa2LLpRgPqgcsY2Kgr+3OZat
         F1WVJ4it6MciTXPIcrmZ9H04pVY0xJldgugyqrsJKxR7j9WC/kLql4QZFuZfgoacXzN3
         ndhNV5thosPdU+eJGwpWdsha92kAJy1pq/9OvBsgnT5vU9BDQFtaNp9c5wxzwbA/85c/
         r0mQzeU9mWybjek9Bqws4m67p1OwtzRMn6/OUXrINtoU73Ep5vDpkK4ctK57m4Zy+HNg
         HX66iNawlWbIi3J63kHIP88Yzxb8HnkTZ2hKjNcFoxuTJ3pVU+KyMmMrzypNRBChwaj9
         dIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qdv+aFAG4ZkTSPXQe/Y2CwqFsr/7AebTPDZjO3hggCI=;
        b=EXZRZCvwGcMlat/VaGCQTvoSdJwZbvT41gCHxZx57hx+DzJKZ3ZrJRvXS6Mo792qLK
         CQ2zafgLD3+1N/tEm8/WUqGoGVmRJKLKPZsmtIBlbsjYnZii3Uq6VCr6rR08HO3hENnH
         gFiCuYCJjOCEBhmFjkTuy6/275QFl+JUiYgb8AObFBPiPt4AmdXi3iEknq5fPWDFD2MT
         eF7VKKRcOBWhsg3ajgyf0tDMWrbspaJea2Jm4CQJ1DpI7nKQStD+NuEtpmw8Dd9JYtVR
         mi5sKn06AYg0/pWGCbvj0RwacmKrW6Snr1N9kNOYNfEUZtj2NARwwnEzwIQLIoTJF1Wi
         KO9A==
X-Gm-Message-State: ALyK8tLBQbTM+S//qfepI85RBaviMBOitY82bbBrNGakUQzzyUfEoUyUtKMQEWtfCwXe7A==
X-Received: by 10.25.83.80 with SMTP id h77mr6358057lfb.83.1466609244166;
        Wed, 22 Jun 2016 08:27:24 -0700 (PDT)
Received: from debian (c83-249-17-125.bredband.comhem.se. [83.249.17.125])
        by smtp.gmail.com with ESMTPSA id bd7sm89696lbc.27.2016.06.22.08.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2016 08:27:22 -0700 (PDT)
Received: from iveqy by debian with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1bFk81-00040Y-R3; Wed, 22 Jun 2016 17:31:45 +0200
Date:	Wed, 22 Jun 2016 17:31:45 +0200
From:	Fredrik Gustafsson <iveqy@iveqy.com>
To:	Istvan Zakar <istvan.zakar@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Problem with --shallow-submodules option
Message-ID: <20160622153145.GB16644@paksenarrion.iveqy.com>
References: <loom.20160620T145755-931@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20160620T145755-931@post.gmane.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 01:06:39PM +0000, Istvan Zakar wrote:
> I'm working on a relatively big project with many submodules. During 
> cloning for testing I tried to decrease the amount of data need to be 
> fetched from the server by using --shallow-submodules option in the clone 
> command. It seems to check out the tip of the remote repo, and if it's not 
> the commit registered in the superproject the submodule update fails 
> (obviously). Can I somehow tell to fetch that exact commit I need for my 
> superproject?

Maybe. http://stackoverflow.com/questions/2144406/git-shallow-submodules
gives a good overview of this problem.

git fetches a branch and is shallow from that branch, which might be an
other sha1 than the one the submodule points to, (as you say). This
is/was one of the drawbacks with this method. However the since git 2.8,
git will try to fetch the sha1 direct (and not the branch). So then it
will work, if(!), the server supports direct access to sha1. This was
previously not allowed due to security concerns (if I recall correctly).

So the answer is, yes this will work if you've a recent version of git
and support on the server side for doing this. Unfortunately I'm not
sure which git version is needed on the server side for this to work.

-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
