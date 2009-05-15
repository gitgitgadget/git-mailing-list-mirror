From: Timur Tabi <timur@freescale.com>
Subject: Removing the trailing "/.git" from gitweb display?
Date: Fri, 15 May 2009 15:49:50 -0500
Message-ID: <ed82fe3e0905151349k15f040aej30dbec82037e9d76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 22:50:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M54Ly-0003XL-8y
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 22:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbZEOUtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 16:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbZEOUtx
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 16:49:53 -0400
Received: from mail-qy0-f129.google.com ([209.85.221.129]:56353 "EHLO
	mail-qy0-f129.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbZEOUtw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 16:49:52 -0400
Received: by qyk35 with SMTP id 35so497148qyk.33
        for <git@vger.kernel.org>; Fri, 15 May 2009 13:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=A2MJafBo+ArrFlm9n0WLd84jivO7g0/op06xPwpxifE=;
        b=TL9rX0ezZOQLlAho+Rr3F1OZpPQP84551k7E/yQuCN1IFQyjagmVdVr64k5fixfEdx
         Io+o9eXbiqVceukuu+UT++2NgA3pX/32Gy+BUvl2bgMp1m+ZZUkhhZ13/2MIlaF+U65S
         NZ/W5IAQxoba2WUs+S5zCM2QbMBXUrytod+q8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=fDz2akZm0tp9h2MsYpnUVQxAvE1P/k6Z0ZqBWdqGjoBsDhH1gWsmHj+r7q/s7gXFpT
         439MRqcDPQCwNywBLf0WM2lQJGqVZvrCSSufDwe8sU49yF9J/S5/d0e8IQWkIFkUYqxk
         WSF5x8+0MGLAT9LNryGvuT8jIBlOnQcx2qg7g=
Received: by 10.229.79.19 with SMTP id n19mr2354120qck.74.1242420590854; Fri, 
	15 May 2009 13:49:50 -0700 (PDT)
X-Google-Sender-Auth: 199ef9aef8613cf1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119294>

I noticed that most gitweb pages show their repositories like this:

bluetooth/bluez-gnome.git 	Bluetooth applications for ... 	Marcel Holtmann
bluetooth/bluez-hcidump.git 	Bluetooth packet analyzer 	Marcel Holtmann
bluetooth/bluez.git 	Bluetooth protocol stack for ... 	Marcel Holtmann

However, mine looks like this:

alsa.1862/.git	8610 audio: fabric driver uses wrong DMA channels for... 	Timur
alsa.2598/.git	8610 audio: migrate ASoC V2 drivers to mainline	Timur
alsa.3313/.git	Introduce spin_event_timeout()	Timur

Notice how my repositories have a trailing "/.git" to them?  How do I
get rid of that?

My gitweb.conf is:

$projectroot = '/home/b04825/git/';
$site_name = "Timur Tabi's git repositories";
$home_link = $my_uri;
@stylesheets = ("gitweb.css");
$favicon = "git-favicon.png";
$logo = "git-logo.png";
$projects_list = '/home/b04825/git/projects_list';
$projects_list_description_width = 50;

And /home/b04825/git/projects_list looks like:

alsa.1862/.git Timur
alsa.2598/.git Timur
alsa.3313/.git Timur

I presume the reason why gitweb shows the trailing "/.git" is because
that's what my projects_list file contains.  However, if I remove the
"/.git" from projects_list, gitweb can't find any repositories.

-- 
Timur Tabi
Linux kernel developer at Freescale
