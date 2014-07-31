From: Duy Nguyen <pclouds@gmail.com>
Subject: [BUG?] log -g does not respect pathspec
Date: Thu, 31 Jul 2014 19:36:02 +0700
Message-ID: <CACsJy8A9eXSkr7Q41AuZUky0d+oLBuYq98eUvVhJFaEXgqoN=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 14:36:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCpb3-00074a-OK
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 14:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbaGaMgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 08:36:33 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:65150 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbaGaMgc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 08:36:32 -0400
Received: by mail-ie0-f176.google.com with SMTP id tr6so3672772ieb.35
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 05:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=HYTYwI9sSwB8GLWWWnPlwt5VUERqQggRw0UrNAMu7R4=;
        b=vS9d+042g45mVO9BlhToqBRtvlfB7OBxQVQDCz2S6jtTKu3HUquuGVcmSivolII3kR
         EfUgoRjGjeMQ9ZIgGkUZ2i8kl2fu78ldM32LerLV6nkzIF0X2DLG7khrWw58BThHP5ET
         /6ACDNw+2HQ/m9XZqWsLphFBof1ZgeQIrD/H9xl8Hfn2Do7HhIMxHSoE3EAiEnMD5FuH
         V4CdltIgO47sYH3eDUsMbX71F1nwF+Not06dfj2Wy4sUK06wKAItqgaxuBeZKXw6f/Yd
         loOgAo+6EybfG5MT5kkUlMEu+1DHeiFzswO+juXz2RDmIuntaiZMFqmgrsxR8dXG7aEp
         EB/w==
X-Received: by 10.50.87.10 with SMTP id t10mr52652513igz.41.1406810192197;
 Thu, 31 Jul 2014 05:36:32 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Thu, 31 Jul 2014 05:36:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254563>

"git log -g" and "git log -g -- something" show the same thing. From
the implementation point of view, I guess that's understandable
because reflog takes a different codepath. But I think the user does
not expect that..
-- 
Duy
