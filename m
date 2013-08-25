From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Sat, 24 Aug 2013 22:07:30 -0400
Message-ID: <CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 04:07:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDPkD-0001wK-GM
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 04:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab3HYCHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 22:07:53 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56294 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab3HYCHx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 22:07:53 -0400
Received: by mail-vb0-f46.google.com with SMTP id p13so1325705vbe.33
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 19:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mNfrlCtORQ/MIq6y7WILizLp6zeiGluCwIio7NS9EzY=;
        b=ONDFAS5T+vIhskmyi7BWWwidH5nKjUgDjX7pjtJEUFm1oXKZHrQYXAhtfhwJDNYS3+
         1V/H0OLnTMGp1kO9XseRoD+Myh0Q6cAJPiiG8HY3XcJrRJIIKMAVWzz1m+cZ/hLo/dHy
         z5eWRuV4BAoKQz5Q/vA2o1WP2mDuzX+i996LlGLxBfVliV47OagoTZ20tLAU2Iv2a3KF
         gf9Pd3qVYCMNxDa7W38bttqVuOqFex+Zi12lJIKq7dkcwASRb3d12zuC/rwF7jTOJv5D
         oeUBSFHO+8kj6w5xmtkbW2OXEfqCOcaz54dZAZQF7oU23KxMGaH/bjp+Vhd62n2cXM5N
         MK4A==
X-Received: by 10.58.198.13 with SMTP id iy13mr7334328vec.11.1377396471330;
 Sat, 24 Aug 2013 19:07:51 -0700 (PDT)
Received: by 10.58.49.197 with HTTP; Sat, 24 Aug 2013 19:07:30 -0700 (PDT)
In-Reply-To: <1377394558-371-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232893>

On Sat, Aug 24, 2013 at 9:35 PM, Phil Hord <hordp@cisco.com> wrote:
>
> When the pathspec given to grep includes a tree name, the full
> name of matched files is assembled using colon as a separator.
> If the pathspec includes a tree name, it should use a slash
> instead.
>
> Check if the pathspec already names a tree and ref (including
> a colon) and use a slash if so.

I think I used lots of wrong terminology there.  What do I call these
things?

HEAD:path is a tree.

HEAD is a commit name.

Maybe like this?

  When a tree is given to grep, the full name of matched files
  is assembled using colon as a separator.

  If the tree name includes an object name, as in
  HEAD:some/path, it should use a slash instead.

Phil
