From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: git-gui: textconv not used on unstaged files
Date: Wed, 24 Oct 2012 20:33:35 +0200
Message-ID: <5088347F.50503@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 24 20:33:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR5m6-0002gt-Ry
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 20:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066Ab2JXSdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 14:33:43 -0400
Received: from mail-in-17.arcor-online.net ([151.189.21.57]:56431 "EHLO
	mail-in-17.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161027Ab2JXSdm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Oct 2012 14:33:42 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mx.arcor.de (Postfix) with ESMTP id 9F473CBD13
	for <git@vger.kernel.org>; Wed, 24 Oct 2012 20:33:38 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 99FA76F2E2F
	for <git@vger.kernel.org>; Wed, 24 Oct 2012 20:33:38 +0200 (CEST)
Received: from [10.0.0.2] (178-190-167-169.adsl.highway.telekom.at [178.190.167.169])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-06.arcor-online.net (Postfix) with ESMTPA id 4DAC310BA2E
	for <git@vger.kernel.org>; Wed, 24 Oct 2012 20:33:38 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-06.arcor-online.net 4DAC310BA2E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1351103618; bh=wFEPJEAiPWsCUKCww9LILd4745qn4yT9yn5jOl0NKEw=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:Content-Type:
	 Content-Transfer-Encoding;
	b=cwrHVroduyDtSZJruSgA4tQYRtjuEXMJG2jXUkEM90Zhr4DstsmaOcyrPlioQUOpj
	 U3a8A3F/jCU8YqEbIBwz5WHgSlnj63Hg+xSbw6FNUnQLLWpLkwGr7/S/AOphU7aDKf
	 a/7dxdh74LoY8BLPhKKw/k86o8jAb8HaBCEwniSI=
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208316>

Hi,

i am using a textconv filter to display .doc files as plain text.
It seems git gui does not use this textconv filter for displaying new 
unstaged files
(other files? = _O)
It seems diff.tcl start_show_diff calls show_other_diff because of this.
This manually loads the file and does not care about textconv filters.

Is this manual loading really necessary or can't we just ask git?
If it is can it be modified to use the textconv filter?

Thanks,
Greetings Peter

.gitattributes:
*.doc    diff=astextplain

gitconfig:
[diff "astextplain"]
     textconv = astextplain
