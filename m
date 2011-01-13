From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/2] unpack-trees: handle lstat failures in verify_absent
Date: Wed, 12 Jan 2011 20:24:15 -0600
Message-ID: <20110113022415.GA8635@burratino>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at>
 <1230843273-11056-2-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 13 03:24:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdCrj-0001FW-Ng
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 03:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538Ab1AMCYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 21:24:38 -0500
Received: from mail-qy0-f194.google.com ([209.85.216.194]:35489 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932361Ab1AMCYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 21:24:37 -0500
Received: by qyk4 with SMTP id 4so329218qyk.1
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 18:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=teUNNpQigTFBMh3Tovl/98FNn2kJ1p5QBs46VstYsT0=;
        b=QzHKi6OfY8RE+DAE3NAAd2gsvBA8Xj0KcIjYoJHY/MIhF6N1Q25EQNZxBR1actZhgJ
         uEsw4wEg89uBnZEe0n4AYrU6Qt0T80Bp/6jkb/6OLstVy6JC8gU+jY5a04BzZIaj2ZbC
         ESTOowzF3Rx3vfGhH3lwGiMgLCdx3fjCB8GNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cqIFPjKwbknprtWcwPfYybntwZ5kzBNJzVWjQGyViRHRunpull2B+En37vFwGcZE+b
         vZwF3zXObPbV6lirCVF07NJrXh0i6a6fpx+achs6qUJ+JY6e1EBd9A7f5ZUztoPpxsni
         EZ7/OuvXIHlKJ3inM6uaKAzxp+YQB5k9wsCGw=
Received: by 10.224.29.6 with SMTP id o6mr1550727qac.380.1294885475535;
        Wed, 12 Jan 2011 18:24:35 -0800 (PST)
Received: from burratino ([69.209.76.37])
        by mx.google.com with ESMTPS id g32sm973724qck.46.2011.01.12.18.24.30
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 Jan 2011 18:24:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1230843273-11056-2-git-send-email-drizzd@aon.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165032>

Here are two cases where we ignore the result from lstat in
unpack_trees.  I think we rather shouldn't ignore it.  Sane?

Jonathan Nieder (2):
  unpack-trees: handle lstat failure for existing directory
  unpack-trees: handle lstat failure for existing file

 unpack-trees.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)
