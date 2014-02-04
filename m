From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: bug? git push triggers auto pack when gc.auto = 0
Date: Tue, 4 Feb 2014 09:41:43 +0700
Message-ID: <CACsJy8Bo4XgA-g2hy+_pVEKLnerL9WNhpWe==zJANmCMdGXuow@mail.gmail.com>
References: <loom.20140204T030158-758@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: chris <jugg@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 03:42:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAVxq-0002K5-V6
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 03:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbaBDCmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 21:42:14 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:60344 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbaBDCmN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 21:42:13 -0500
Received: by mail-qa0-f45.google.com with SMTP id ii20so11123134qab.4
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 18:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=spvqmF2S6PGnVYnlPvcyiB94mGlfT4vYVKYevXgSh2o=;
        b=mHi28PcrNmDgAFGVEQetyqVUCvP/lOUC0ptDBpWizvLTOaqRpV4N4VYiZ3rDA7eHT9
         pF2dGlXVG6gtm8lhwNpt6CWpZPKteC2anTortLmCN0CzAktufH+l50jgQ90XfQCo5xYE
         wM535vKKd711yWmxydQnhxytHRHd4ltUvhVF7U+O9X45vKfywhFo08f/Y8hmUKuceFoj
         63WQzrtVdkXyayXdLllGCc713zNoFsjmYnFGNIUA+50ljthfIuomdI4w7UlQ9+G/vtw6
         Oem7+Sesno2x/CC0jUWgK1s4BO+ddE9zOAeOpUlIP2bUWmdXxrP+6jeWiHe877zXMWKR
         vZFw==
X-Received: by 10.140.93.130 with SMTP id d2mr57768518qge.41.1391481733501;
 Mon, 03 Feb 2014 18:42:13 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Mon, 3 Feb 2014 18:41:43 -0800 (PST)
In-Reply-To: <loom.20140204T030158-758@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241509>

On Tue, Feb 4, 2014 at 9:20 AM, chris <jugg@hotmail.com> wrote:
> $ git push origin next
> Counting objects: 56, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (9/9), done.
> Writing objects: 100% (9/9), 895 bytes | 0 bytes/s, done.
> Total 9 (delta 8), reused 0 (delta 0)
> Auto packing the repository for optimum performance.

This string only appears in versions before 1.8.0. It's longer after 1.8.0.

> To ssh://git@my.server.com/my_project
>    3560275..f508080  next -> next
> $ git config gc.auto
> 0
> $ git config gc.autopacklimit
> 0
> $ git --version
> git version 1.8.5.3

but your client is after 1.8.0 so the string printed above is from the
server side. "git config gc.auto" here does not matter. Run that
command again on my.server.com.

> So my question is, should gc.auto = 0 disable auto-packing from occurring on
> git push and other non-gc commands?

Yes it should.
-- 
Duy
