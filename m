From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How git detects changes during commit?
Date: Wed, 27 Oct 2010 15:54:41 -0500
Message-ID: <20101027205441.GA8242@burratino>
References: <1288211811436-5680208.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: longphant <longphant@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 22:54:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBD1L-0002z7-5A
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 22:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083Ab0J0Uyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 16:54:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61612 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab0J0Uyt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 16:54:49 -0400
Received: by fxm16 with SMTP id 16so1121635fxm.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 13:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Yx61mOaohqNsIELCi0L80PGtTTtEfBxMMeGubL3jGx4=;
        b=Rd2iJxAJu6nSg3dmvOVGe3l+t+8ZqnW4URwkKf40CU7IGX4xCSlhjgozUUWBUIiyOe
         TB5UsxJV0+UhZrLdvxSbjeNL8iaMSraWho3GzJQa+gtTeu37Mnd3MrRw++KEu8GrD+EH
         VK7BHu3IJy+Eg8qDXFW3mb9sP1fJNywhaOL20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dO6DPkqQ8smrhkp1gMZEewkpdE1mytbaW5BBWmlPNuiWnaslYb7THKLdrNYl5Y9AhM
         jyXVEfSKovUA48EUSTir30tmJU8DQlWpr8worgx+3FmrX469lnwBfxpJ5dKhqnZwbWNG
         GuNGcO7I0yb88OiHbD8WbdWGHBQlgkMBUKvDw=
Received: by 10.223.70.129 with SMTP id d1mr1461004faj.1.1288212888476;
        Wed, 27 Oct 2010 13:54:48 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id s18sm134655fax.10.2010.10.27.13.54.46
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 13:54:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288211811436-5680208.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160124>

Hi,

longphant wrote:

> Say you check out a directory of 100 files. You edit 5 of the files, and you
> go to commit the directory back. How does git know which of the 100 files
> were modified (not all of them were)?

The lstat system call.  See the git-update-index(1) manual for some
hints (since most high-level commands do the equivalent of
"git update-index --refresh -q" before working with the work tree).

Hope that helps,
Jonathan
