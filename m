From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Thu, 8 Aug 2013 14:08:39 -0500
Organization: Exigence
Message-ID: <20130808140839.56c8343f@sh9>
References: <1375983492-32282-1-git-send-email-stephen@exigencecorp.com>
	<1375983492-32282-2-git-send-email-stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, avarab@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 21:08:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7VZo-0006Md-0U
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 21:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966188Ab3HHTIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 15:08:43 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:62604 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966186Ab3HHTIm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 15:08:42 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so5821983oag.41
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 12:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-type:content-transfer-encoding;
        bh=V8lH051VAuhq5Yljc9IZpYLYp/yIO6zCHsHJY1Xh7ss=;
        b=VjkebPet9VNdskuhbi7aFLmnvS5aB+fcFAedtn0EZXjl7LvaKdivANtcbCta7et8Jo
         QnJ9VFF1uOfjW8ZWkA9/sn3T224PKvx0E8HjRKM4paR8Bx88PgGXAlTnyDDlb0DWCVCl
         RwSUR20iiqUfZLdzEojqIrBow04D1glrxR9Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-type
         :content-transfer-encoding;
        bh=V8lH051VAuhq5Yljc9IZpYLYp/yIO6zCHsHJY1Xh7ss=;
        b=hWEmnxsyOeBfnCLZAtQgu2jIpKZeIvla9PbxxY5N3726cnDdqnEN0hjYIiXAlIj3Fl
         k1S/OIfbattTLpMZEE0kKamcJQe2IIryk0xn2xBKh/9VL8vu0h3gi9OTgnB4EjlnwwgT
         867zyiPoKj+Le1bntxObbJ9keswa8RBj8F9cSZLcYb0XAUkhsUxh9Prhv+ufZpGlX8Uz
         9W/QvxY2B4crXT2fY/wg7kuJxNX5sbRPJBlFYfLHAmhN2/4gJRs7a1SDqoPUmpcqrjdw
         19eO9yn+eiM9ti//Kpjv2DE5Lk6L69xDR8eVH8xwlopLk7dXfypFsae5xElBksocO1Sr
         94xw==
X-Gm-Message-State: ALoCoQmQp1WkUGEOF/jUfKhSkYbC9UFdnx2V9z35AM54yQPe/6VkACWP0hEL5CT2yt9b4eO4AMzf
X-Received: by 10.60.133.133 with SMTP id pc5mr5391072oeb.63.1375988921225;
        Thu, 08 Aug 2013 12:08:41 -0700 (PDT)
Received: from sh9 (wsip-184-187-11-226.om.om.cox.net. [184.187.11.226])
        by mx.google.com with ESMTPSA id jz7sm14965126obb.4.2013.08.08.12.08.40
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 12:08:40 -0700 (PDT)
In-Reply-To: <1375983492-32282-2-git-send-email-stephen@exigencecorp.com>
X-Mailer: Claws Mail 3.9.1 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231921>


> This is because "git pull" currently does not know about rebase's
> preserve merges flag, which would this behavior, and instead replay
> on the merge commit of the feature branch onto the new master, and
> not the entire feature branch itself.

Ack, sorry, I was doing this too late last night--should say:

This is because "git pull" currently does not know about rebase's
preserve merges flag, which would avoid this behavior by replaying the
merge commit of the feature branch onto the new master, and not
replaying each individual commit in the feature branch.

- Stephen
