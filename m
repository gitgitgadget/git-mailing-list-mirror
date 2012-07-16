From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Escape file:// URL's to meet subversion SVN::Ra
                     requirements
Date: Mon, 16 Jul 2012 20:16:38 -0000
Message-ID: <ab115eb531ab4229a3edb12670ca4179-mfwitten@gmail.com>
References: <1320251895-6348-2-git-send-email-bwalton@artsci.utoronto.ca>
            <20111102182015.GA11401@elie.hsd1.il.comcast.net>
            <1320260449-sup-479@pinkfloyd.chass.utoronto.ca>
            <20111102220941.GA3925@dcvr.yhbt.net>
            <1320372215-sup-8341@pinkfloyd.chass.utoronto.ca>
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Jul 16 22:17:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqrjx-00021d-Bt
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 22:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209Ab2GPURw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 16:17:52 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:60826 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab2GPURv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 16:17:51 -0400
Received: by weyx8 with SMTP id x8so4207530wey.19
        for <git@vger.kernel.org>; Mon, 16 Jul 2012 13:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=T9/PfUyp1TExT3PhErzX2nvAgx/DSEqsK1tDZj4HJVw=;
        b=nhhhvwBatIVa3k73G+ddQHV+vzj4WxtIZZ4qMNcNxKffkRp1T4+yi5G0YbYzW97jOH
         nCl1lJ9v0cYxC6bk43RhcSPuqwvuz0VdA4m3FzZVUuUj7wFK/K3jhfQict0OpFqhw8Wb
         CSLBPDhxsBz98BldJ/B6vDsKycu2jPIsTBUV/dp3r1w7DAM6tSvbzDAORNxeg/bucg7E
         p0kHpx5prg54f0uuU3oFqZ/tzfWgIl9Qg9+ZnVCucekajsUjs5bbRlI87rPGoCMX95Ae
         zBXRaEc34E1uaPODL3vDoyQy+KL0eb28WxrYoUBFSuTahKOpQn1pQE0kAI0C89HB1V1I
         5Z1Q==
Received: by 10.216.59.7 with SMTP id r7mr4006345wec.19.1342469869812;
        Mon, 16 Jul 2012 13:17:49 -0700 (PDT)
Received: from gmail.com (tor21.anonymizer.ccc.de. [31.172.30.4])
        by mx.google.com with ESMTPS id y2sm23166593wix.7.2012.07.16.13.17.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jul 2012 13:17:48 -0700 (PDT)
In-Reply-To: <1320372215-sup-8341@pinkfloyd.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201566>

On 2011-11-04 02:11:49 GMT, Ben Walton wrote:

> Excerpts from Eric Wong's message of Wed Nov 02 18:09:41 -0400 2011:
>
> Hi Eric,
> 
>> I don't have much time to help you fix it, but I got numerous errors
>> on SVN 1.6.x (svn 1.6.12).  Can you make sure things continue to
>> work on 1.6 and earlier, also?
>
> Yes, it's a bit of a mess, I think.  It looks as though the
> modification required within Git::SVN::Ra is going to negatively
> impact other code paths that interact with that package from the
> outside.
>
> For example, when doing git svn init --minimize-url ..., the minimized
> url is not escaped while the url is.  The minimized url is used to
> strip off the head from the full url using a regex.  This now breaks
> because of the escaping.
>
> Fixing this locally to the use of the minimized url let me move on
> farther but I then got another core dump.
>
>> Maybe just enable the escaping for file:// on >= SVN 1.7
>
> I think that it would be best if this change was only effective for
> 1.7.
>
> I wonder if all URL-ish objects should be (conditionally iff svn >=
> 1.7) subjected to escaping?
>
> This would require some restructuring and will take me a bit of time
> to work out as I need to familiarize myself with the code to a deeper
> level.
>
> Pointers welcomed. :)

This problem still exists. It should be fixed---preferably by the people
who built this apparently unwieldy contraption.

Sincerely,
Michael Witten
