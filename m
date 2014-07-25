From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] refs.c: update rename_ref to use a transaction
Date: Fri, 25 Jul 2014 13:00:09 -0700
Message-ID: <20140725200009.GJ12427@google.com>
References: <1406307521-10339-1-git-send-email-sahlberg@google.com>
 <1406307521-10339-5-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 22:00:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAlfA-0002zM-DS
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 22:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbaGYUAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 16:00:13 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:47767 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932145AbaGYUAM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 16:00:12 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so6670484pac.31
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jFj58xM3oWOhrRjJcpe3KKcSiRB+MT/FoaISMXdXMnc=;
        b=xENUqxAfNEKMSqfICpUlyOodB+Rhx20bDjWf06hzrjE26/o8h+bHB7y+UfX3Anbu1v
         M8IjzR7L43Ii3BSYx/9qPk11UMuNUbpn7XAB3AOshoYkOQNREHJVsP7VfvD6p1cQe4BO
         k21z4ghMCHZPSBry9kKhTUtZkZPXDJUnjQ2iyHwBLNke2FxtcOWlzmaW5OlIcEzJc5Zl
         iVjbTN8hvxrsaXAD44MQYjcWDaF6gKKf/I6QJvZf01NSl51CICZwMaPCOl9ii2aiJfkC
         UYsXDx9eRR+/lh7R/IhjM87NOsTAYrH/AlvaRIsjIOpkwJ/E9pUwx/7Z79IcUPrprKMf
         JG9w==
X-Received: by 10.68.204.134 with SMTP id ky6mr13872960pbc.61.1406318412075;
        Fri, 25 Jul 2014 13:00:12 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:11c3:a287:a529:3c10])
        by mx.google.com with ESMTPSA id d13sm9696253pbu.72.2014.07.25.13.00.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 13:00:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406307521-10339-5-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254267>

Ronnie Sahlberg wrote:

> Change refs.c to use a single transaction to copy/rename both the refs and
> its reflog.

Yay!

>             Since we are no longer using rename() to move the reflog file
> we no longer need to disallow rename_ref for refs with a symlink for its
> reflog so we can remove that test from the testsuite.

It's generally better to update the testsuite with the new expected
behavior instead. :)
