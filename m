From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: A question about the error: svn_fspath__is_canonical
Date: Fri, 10 Jan 2014 11:16:50 -0800
Message-ID: <20140110191650.GF4776@google.com>
References: <CABRpx=1CvB55zeL1L8QOvyfbJCaG9FK+HEz-iK9cFGrnxmOJtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan Kaplan <dank@mirthcorp.com>
X-From: git-owner@vger.kernel.org Fri Jan 10 20:17:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1hZi-0001DO-U9
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 20:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbaAJTQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 14:16:55 -0500
Received: from mail-gg0-f181.google.com ([209.85.161.181]:55684 "EHLO
	mail-gg0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbaAJTQy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 14:16:54 -0500
Received: by mail-gg0-f181.google.com with SMTP id 21so539872ggh.26
        for <git@vger.kernel.org>; Fri, 10 Jan 2014 11:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TClkmpIz8icq/8mD11VkPtyY0PElAA+zaFughWri5XM=;
        b=lWZ7mH5XyBrZXddeJtlNJY3cgDbMl1WHbktLOjIY7wdI1bCJm3aDfiswizyheitKNR
         88ANfZ4j255qgVSx1bePTxwVFbvSQT7eZdFFjrc1ska+yEBfLeTQtUTL3aTlqwg/SeHX
         2rz12Xydxq50yW2B4WD2XtbzoFwty224TwBd7xCF2BAXVA6jjL3AZ9/wRmjTM0okqkP/
         sL8oQwRGPxQED/kGvkv5ExfWZCVy0+VaPBqkVzdl7wfcSvTAQrWCpO2hDsbT5k3DH/4H
         PMC4XhVSU36S+6y3XyfUcmaOK6k4sRkgwzXDTYtLyyAyHm7qQ0lBuRiRmed5DS2YAzv5
         33hQ==
X-Received: by 10.236.105.236 with SMTP id k72mr13469224yhg.30.1389381413219;
        Fri, 10 Jan 2014 11:16:53 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id w45sm12988728yhk.4.2014.01.10.11.16.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 Jan 2014 11:16:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CABRpx=1CvB55zeL1L8QOvyfbJCaG9FK+HEz-iK9cFGrnxmOJtg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240309>

Hi Dan,

Dan Kaplan wrote:

> My environment is probably different from most.  I'm using cygwin.
> This makes it very difficult to use different versions of
> git/svn/git-svn, but I'm interested in learning git more so I'm
> willing to try whatever it takes.
>
> $ git version
> git version 1.8.3.4
>
> $ svn --version
> svn, version 1.8.5 (r1542147)
>    compiled Nov 25 2013, 10:45:07 on x86_64-unknown-cygwin

You have three choices:

 A) upgrade git to latest "master"
 B) upgrade subversion to latest "trunk"
 C) downgrade subversion to a version before that bug was introduced

(A) is probably simplest.  E.g., something like the following should work:

  git clone https://kernel.googlesource.com/pub/scm/git/git.git
  cd git
  make -j8
  make test; # optional, to verify that the git you built works ok
  export PATH=$(pwd)/bin-wrappers:$PATH

Now the updated git is in your $PATH and you can use it.

See INSTALL in the git source tree for more details.

Hope that helps,
Jonathan
