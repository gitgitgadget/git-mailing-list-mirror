From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] commit: add commit.signoff config option
Date: Thu, 25 Jun 2015 10:43:02 +0200
Message-ID: <CAP8UFD1kbu4uB1Xaf_jWdQUBzkSJ-Z3_o3NT0Wb6GNyRG=jSLw@mail.gmail.com>
References: <1435217558-5866-1-git-send-email-cmarcelo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 10:43:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z82kj-0005P8-DC
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 10:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbbFYInK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 04:43:10 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:33250 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbbFYInD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 04:43:03 -0400
Received: by wgck11 with SMTP id k11so56270564wgc.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 01:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xEhkrUs4H5U7J9JbSypQI2MPSwspF1YO+X8BB4x4+6w=;
        b=GwxOgajVBpR8dCGzou49GulF2tYIjiJwJFYtrutDWuh9TBWPXonPoYXijtbTzVIMEv
         4NYC6YQGHqxkTi/I6XOj/xPdxXJOwdYPcJ1DdoFFmCJEJj2YUPt5x8bWO9vj2pqyqI5T
         TQHHYHC6c5zX12nEkHf9dXbhgqeVA2FxcAcrOLKAHoW7c2I0SBcfCg/Wm40fYLngu29s
         yxmVWV6BchcpDelefRaSQgud4fbgkAP4+DDPew0T9cdPMJ5wjC2MXR0rxsisK+Q+8Czj
         9frXFMeNJ6iuNDDzlJTfycqwyrx3PTvDWMcyoY2QPY9YAKuuwLNPoLUbXueGmx/fggsx
         fI1Q==
X-Received: by 10.180.95.10 with SMTP id dg10mr3632178wib.41.1435221782429;
 Thu, 25 Jun 2015 01:43:02 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Thu, 25 Jun 2015 01:43:02 -0700 (PDT)
In-Reply-To: <1435217558-5866-1-git-send-email-cmarcelo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272640>

On Thu, Jun 25, 2015 at 9:32 AM, Caio Marcelo de Oliveira Filho
<cmarcelo@gmail.com> wrote:
> In projects that use Signed-off-by, it's convenient to include that line
> in the commit by default. The commit.signoff config option allows to add
> that line in all commits automatically.

You can use a commit template.

Or you can use the "commit-msg" hook. For example with commands like:

grep "^Signed-off-by:" "$1" ||
echo "Signed-off-by: $(git config user.name) <$(git config user.email)>" >>"$1"

If you have more complex needs, there is also "git interpret-trailers"
(see the examples in the man page).
