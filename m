From: Kevin <ikke@ikke.info>
Subject: Fwd: possible Improving diff algoritm
Date: Wed, 12 Dec 2012 16:03:08 +0100
Message-ID: <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:27:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TioDr-0007M3-ED
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 16:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab2LLP1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 10:27:31 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:56357 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab2LLP1a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 10:27:30 -0500
X-Greylist: delayed 1441 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2012 10:27:30 EST
Received: by mail-wi0-f173.google.com with SMTP id hn17so2766429wib.12
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 07:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=voWAlVzgIK993b811yBG/V9F0FFUh9dbGLxBNPvWZOE=;
        b=UEGAYGfgHTt74Xu43Pk0T4TbsISP2SECrHYVjyEyowEg/qUweLWPUwTZOOX5TLnV2G
         7UZ5aCq7TZJwDmYFwR9X4BAKSYDTkO5xeyRgYm8yQjY+qwYjK1noAQDt7d8l9dviEusx
         CzhtUKugJwNWr89MPTQYu7EVJ+5DMQvlUdbBpmx0vIhPAqTRQZCY43oTWnpCMRH1w6eM
         Q9gse0rhpyzulaeh5pvp8bkTD/EC3p6rg35glDxXNLmKSFc6BhAfsD5oTVy+Hlwn4Z9u
         qOofN/J72QDrh8kN6Z5kRq/cs72ju2LIhWWSZEzatqi1Gi50igADhEePPVUlsmGYus5d
         fB4A==
Received: by 10.180.99.71 with SMTP id eo7mr3647380wib.11.1355324608494; Wed,
 12 Dec 2012 07:03:28 -0800 (PST)
Received: by 10.227.9.14 with HTTP; Wed, 12 Dec 2012 07:03:08 -0800 (PST)
In-Reply-To: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
X-Google-Sender-Auth: lgrprt_ps3_2jBJDt__LL7EC80o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211359>

Regularly I notice that the diffs that are provided (through diff, or
add -p) tend to disconnect changes that belong to each other and
report lines being changed that are not changed.

An example for this is:

     /**
+     * Default parent
+     *
+     * @var int
+     * @access protected
+     * @index
+     */
+    protected $defaultParent;
+
+    /**

I understand this is a valid view of what is changed, but not a very
logical view from the point of the user.

I wondered if there is a way to improve this, or would that have other
consequences.
