From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Corruption: empty refs/heads in otherwise filled repo: cannot clone?
Date: Mon, 30 Jun 2008 14:03:57 +0200
Message-ID: <200806301403.57900.jnareb@gmail.com>
References: <200806301149.18115.J.Wielemaker@uva.nl> <200806301326.12140.jnareb@gmail.com> <200806301344.09938.J.Wielemaker@uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Wielemaker <J.Wielemaker@uva.nl>
X-From: git-owner@vger.kernel.org Mon Jun 30 14:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDI84-0003FZ-FM
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 14:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307AbYF3MEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 08:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757368AbYF3MEK
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 08:04:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:61110 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213AbYF3MEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 08:04:09 -0400
Received: by nf-out-0910.google.com with SMTP id d3so425347nfc.21
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 05:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=S/kC6z8nsjjbbs3l7cUZ+jPWXucSOneh5ymId6/9Cis=;
        b=NLdTWyqEvwDBLiQpum/Ki87MKuQoxrJPLkMWZ/mmMi+tPUJpmN6OiReQ/yc3dkws/u
         MgTeRmhAcVKJNPveOZP0F8GS0l9o86Fw1iMrKuHyS9kYaMPQolgahLJpJtghwYarO5mP
         iBy61ommUCj3xvqJjEGL/b5zn3aMhkhmLHzDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KHPDqPSXSIHjHgc2x5OOSwIt3Za/E/wX7FEz2d9xmvZCNymQzFK6xIefyIZ0T5ZpWm
         +nitCmR5WsarzcHEYqVBqgqYghKbyO3lo+PIgCx4dlb8Gho6KwptH6y5X72AHHpFrJzE
         KpNzJMRNuG6MQmY9zRcdg6r/DYxP0BGe4jAGE=
Received: by 10.210.91.17 with SMTP id o17mr4070901ebb.172.1214827447338;
        Mon, 30 Jun 2008 05:04:07 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.210.122])
        by mx.google.com with ESMTPS id 33sm3539362nfu.7.2008.06.30.05.04.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Jun 2008 05:04:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200806301344.09938.J.Wielemaker@uva.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86911>

Jan Wielemaker wrote:

> Summarising, I think the conclusion is that git pack-refs has somehow
> been run on this repository, and being a bare one this is not a
> particulary good idea right now. I have the impression I should `unpack'
> them by putting the appriate files in heads (done) and tags (now still)
> and (re)move packed-refs.

If you use new enough git both on server and on clients it should
not have problems with packed-refs. I would rather check permissions
of $GIT_DIR and $GIT_DIR/packed-refs.

If "git show-ref" and "git for-each-ref" works, then 
"git ls-remote <repo>" should work, and git-fetch/git-clone
shoulw work too...

-- 
Jakub Narebski
Poland
