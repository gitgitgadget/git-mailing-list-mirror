From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: [PATCH] gitk: Synchronize highlighting in file view when scrolling
 diff
Date: Tue, 18 Sep 2012 20:23:49 +0200
Message-ID: <5058BC35.6050007@arcor.de>
References: <1347947874-38597-1-git-send-email-stefan@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Stefan Haller <stefan@haller-berlin.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 20:24:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE2So-0000IQ-K2
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 20:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561Ab2IRSXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 14:23:54 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:38557 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753133Ab2IRSXx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 14:23:53 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mx.arcor.de (Postfix) with ESMTP id 2C4ED108726;
	Tue, 18 Sep 2012 20:23:52 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 2725F208013;
	Tue, 18 Sep 2012 20:23:51 +0200 (CEST)
Received: from [10.0.0.1] (93-82-73-33.adsl.highway.telekom.at [93.82.73.33])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-02.arcor-online.net (Postfix) with ESMTPA id 2B11830491;
	Tue, 18 Sep 2012 20:23:51 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-02.arcor-online.net 2B11830491
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1347992631; bh=7X98Tg1LO+j4FB6749krbWghqyPhvH03IIS5tykhm8I=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=G1C0QtFmIGRDA+xw1S+NBSKJq56q/IpbEpRLimdO/ksycFReSAbuUmvuY133b9OMH
	 WrdaBKfblIeFlMrqnJoM34X6pJSmCtUw02coNMW2iiUhs1H+KHCQ09Q/TDw041mZPZ
	 QV4X8GknjEzJavs/GoowdyEofF4vbPNXupY+RnkY=
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <1347947874-38597-1-git-send-email-stefan@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205845>

On 2012-09-18 07:57, Stefan Haller wrote:
> Whenever the diff pane scrolls, highlight the corresponding file in the
> file list on the right. For a large commit with many files and long
> per-file diffs, this makes it easier to keep track of what you're looking
> at.

Hi,
i like this function!
I have often lost track which file i am currently looking at.
Especially with long files.

But i noticed following minor thing:
When selecting a new commit, for a split second the first file name is selected
and then the "Comments" entry is selected.
The flickering is more visible when you hold down the mouse on the up/down button
of the "Lines of code" field.

Can this flickering be avoided?

Thanks,
Greetings Peter

> This allows simplifying the prevfile and nextfile functions, because
> all they have to do is scroll the diff pane.
>
> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
> ---
>   gitk | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)
>
>
