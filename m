From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gitk doesn't always shows boths tags in "gitk tag1..tag2"
Date: Tue, 29 Jan 2013 11:57:18 -0800
Message-ID: <20130129195718.GD18266@google.com>
References: <510825B2.6070805@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 29 20:57:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0HJR-0001OZ-LY
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 20:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab3A2T5Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 14:57:24 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:38392 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab3A2T5X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 14:57:23 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so593034pad.22
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 11:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5e1zF2m5Z1CF7/cFEhQb469qQU6txy0OLJcY906Aeo8=;
        b=MC5Kt05Yy/7u/t5AiNKHJgqCaYaloKYfOlWsAw9Lh9piYIy4uzYIgyE0YSvgrfDoMS
         DPOTA+KuIeP4fm2Bh41QQ0/96le9FfLEWUI4dYFIzQLxo2NvJvJ3A5+5eSqfnyUOnNAS
         27uYRJCHvwkNUyz52BVVNNOrakQecAnmzxu67q5QX55cm2+8benajNbLuJxeAAOklBhG
         NT/PwxcepE4xFS+VgY9LvfDtJzPp7++mie0oGFvolgXItdmapKyuidUAYN2d3vz+1P3P
         wP2TAHAYomFUvB/2rR0f9eUmhcdZ9N1B+QprW6b8fUH3uMYqSNwnawyjmILmsStboS29
         1Rew==
X-Received: by 10.68.248.68 with SMTP id yk4mr5268718pbc.154.1359489442620;
        Tue, 29 Jan 2013 11:57:22 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id bi8sm9580677pab.15.2013.01.29.11.57.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 11:57:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <510825B2.6070805@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214967>

Hi Toralf,

Toralf F=F6rster wrote:

> $> git clone git://boinc.berkeley.edu/boinc.git
>
> the following 2 commands shows both starting and ending revisions :
>
> $> gitk client_release_7.0.41..client_release_7.0.42

gitk is running something similar to

	git log --graph --decorate --boundary --oneline <revs>

In this example, that means 7.0.41 is shown with an open circle
because it is at the boundary of the requested commit set (it is not
in that set and one of its children is).

[...]
> however this command doesn't show the tag "client_release_7.0.44" :
>
> $> gitk client_release_7.0.44..client_release_7.0.45

As you guessed, 7.0.45 seems to live in a different area of history. :)
I don't know why it was built that way --- there may or may not be a
good reason.

"gitk --simplify-by-decoration client_release_7.0.44...client_release_7=
=2E0.45"
can help to compare the positions of the two tags in history.

Thanks for a fun example.
Jonathan
