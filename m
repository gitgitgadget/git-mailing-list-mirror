From: Jacob Keller <jacob.keller@gmail.com>
Subject: builtin/tag.c issue with sort option
Date: Tue, 28 Jul 2015 15:27:40 -0700
Message-ID: <CA+P7+xrkGh5iB2XunqRyU-iRfeFPq_ni0nPAMn-4gZVO-spnEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 29 00:28:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKDLy-0001iI-Nf
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 00:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbbG1W2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 18:28:00 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38228 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbbG1W2A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 18:28:00 -0400
Received: by iggf3 with SMTP id f3so1075943igg.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 15:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=bMtQpjoSbc/CYqhziWVGkczV5hsThHfHmdi5DJQA0/s=;
        b=UDHwrqhavypvdRLia7uT5Ruo0dreeMbq+isBomTO5cWRfJbAAHlDgwnt6IxWgYkfI9
         cIHh/X0nzWsaLuLaVYvAXYRLh5TWI2slD9enSyk4iax9YDZNWv+qsMmlGwWI5DTbNW7j
         PHt1vISI8yy7/qawEFLfMcAOWLmbI7AZ/G0uBt2gj5rmxFZI+XZ5AD+7W5cYIzs3XLQR
         aZgXiZqyESudKQKeGAPgiDz0WwHpDjMbPfh2gSlPhbCoEgEwwAfuWYMfTImkALTJGN3i
         a1XJYw2wBckUB2LsC0M7ptNDf1WntXNdNgqGbAkXyADeVrjOeruhp4Jl3CE9A9oeiGc7
         BqTw==
X-Received: by 10.50.43.131 with SMTP id w3mr10780916igl.8.1438122479704; Tue,
 28 Jul 2015 15:27:59 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 28 Jul 2015 15:27:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274861>

When passing "-n" on the command line, if you have configured sort
manually, you get an error as it thinks you passed --sort and -n.

It should automatically disable tag_sort if it wasn't passed from the
command line, as you probably know what you are doing when passing -n

I'm attempting to work up a patch for this fix, but I am having a
little bit of trouble and want to make sure it's right to fix this
behavior.

Regards,
Jake
