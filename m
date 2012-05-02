From: bill lam <cbill.lam@gmail.com>
Subject: Re: git pull and GIT_DIR
Date: Thu, 3 May 2012 07:21:02 +0800
Message-ID: <20120502232102.GB2609@debian.b2j>
References: <20120502142536.GA2609@debian.b2j>
 <7v62ceiejp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 03 01:26:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPiwA-0004f9-3L
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 01:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550Ab2EBX0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 19:26:17 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54353 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab2EBX0R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 19:26:17 -0400
Received: by pbbrp8 with SMTP id rp8so1696208pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 16:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9CVbTQCxjd+ZG2Va9wZerSZjiSLnbyia1gf42l1Q2uU=;
        b=QqS7VZPJHfjlqOo/xk4be3HAhITu01yaxbA0cSUWiQgtmqSATDv86BGPm9+Yn62d3n
         PRICio9xxKjsFz+yose3w9x2eZuX0Sg6ag1O7KiOTLKXuhI1uJXuK64ORL5KndETanX7
         AF+xHdP6efc+nNTIGbaXB6pDGAAdhdhx7d4SI0N7JXwXbHseg9OyuXPhyKfuewokKAlZ
         0A+Fq2Ze2JEu+/a3WTF5OViNRIVSSJKGCJzrI+Xx11DeOzbjeotGxy1lwzXX3llmTORb
         imGeqbJBqqQwchwa5qJVSEQmTWgqx4pXPg0IL/BHQs59G611arU/DfSkoh/G0moH06ib
         i/dg==
Received: by 10.68.194.1 with SMTP id hs1mr1839801pbc.6.1336000871005;
        Wed, 02 May 2012 16:21:11 -0700 (PDT)
Received: from localhost (n1164843249.netvigator.com. [116.48.43.249])
        by mx.google.com with ESMTPS id u5sm3258335pbu.76.2012.05.02.16.21.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 16:21:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v62ceiejp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196870>

It is non-bare and /path/to is the working tree.  The git pull was
run inside a shell and $(pwd) is $HOME.  GIT_WORK_TREE is not used.
This let me remember that there were some directories/files checkout
under $HOME that should be under /path/to.  I might recall
incorrectly, but does it mean that it need to use the form

GIT_DIR=/path/to/.git GIT_WORK_TREE=/path/to git pull url

to make it to the samething as

cd /path/to && git pull url

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
