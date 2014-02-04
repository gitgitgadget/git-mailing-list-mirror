From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: Re: [PATCH v5 4/5] setup: Add 'abspath_part_inside_repo' function
Date: Tue, 04 Feb 2014 19:32:47 +0100
Message-ID: <1391538767.4905.30.camel@mule>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
	 <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
	 <1391358940-17373-5-git-send-email-martinerikwerner@gmail.com>
	 <xmqq1tzjewsf.fsf@gitster.dls.corp.google.com>
	 <20140203231659.GC15607@mule>
	 <xmqqlhxqagwt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 19:32:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAknn-0004TN-ON
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 19:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbaBDScx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 13:32:53 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:64265 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbaBDScv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 13:32:51 -0500
Received: by mail-lb0-f173.google.com with SMTP id y6so6728426lbh.18
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 10:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=M8EOAfcxXNdO+H4HfiEZ8cvlPxffcUGCGr+ox2hQgnE=;
        b=jhYZXM4thtCp37ew7K0qaFoweFb5WY+tkkdpv9am5j+TjXH1UTBKQy0N0ZkUfIONWY
         u1eGJYzi/djcZUQuchMabtJKonwzOBPFlyS0UHWFWs7NS205d4pjYZr/dMJ6gloXOD3n
         OShesOtTPZgOz28cDL8+d32A6M2D5mnL3ZfWsySFOe8Lx8rrVlU+B7TGQCIUzeCsK8Rp
         s0/oWhkwWjOeyoN4fUcrGBQZDolYjzfI/qzrAC134fLJvhaVitF3UiTmaIWcqreba9Wo
         8bDib1jAfuevb5GduRpJ87y27rI9EXT5e96mwOdkGn5XKr4NrB0NalXYw0ClAVB9e5SE
         Msgg==
X-Received: by 10.112.33.108 with SMTP id q12mr4869484lbi.8.1391538770118;
        Tue, 04 Feb 2014 10:32:50 -0800 (PST)
Received: from [192.168.0.101] (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id h7sm26150355lbj.1.2014.02.04.10.32.48
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 04 Feb 2014 10:32:49 -0800 (PST)
In-Reply-To: <xmqqlhxqagwt.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.8.5-2+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241535>

On Tue, 2014-02-04 at 10:09 -0800, Junio C Hamano wrote:
> Martin Erik Werner <martinerikwerner@gmail.com> writes:
(...)
> > I was trying to convey that if path is simply "/dir/repo", then the while
> > loop method of replacing a '/' and checking from the beginning won't
> > work for the last level, since it has no terminating '/' to replace, so
> > hence it's a special case, mentioning the "part inside the work tree"
> > is arguably confusing in that case, since there isn't really one, maybe
> > it should be left out completely, since the "check each level"
> > explanation covers it already?
> 
> I dunno about the explanation, but it still looks strange to have
> the special case to deal with "/dir/repo" before you enter the while
> loop, and then also have code immediately after the loop that seems
> to handle the same case.  Isn't the latter one redundant?

The check before the loop doesn't use 'real_path', the one after does:
"/dir/repo" vs "/dir/repolink"

-- 
Martin Erik Werner <martinerikwerner@gmail.com>
