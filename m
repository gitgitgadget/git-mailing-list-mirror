From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] TIG: Fix to reinstate proper operation with no arguments
Date: Fri, 19 Jul 2013 00:07:05 -0400
Message-ID: <CAFuPQ1K=hWUSCEhaGsuW8PeoGQcj6AoPo61zUTDbjLE802h+7g@mail.gmail.com>
References: <1374123113-3889-1-git-send-email-n1xim.email@gmail.com> <51E7EDE3.4080205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 06:07:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V01yd-0004US-Ih
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 06:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975Ab3GSEH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 00:07:27 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:47935 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861Ab3GSEH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 00:07:26 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so4735624obc.31
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 21:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=ZS1WzuDwyoD0pqNb4KsasdveEz95NyHuN2VdH1BzgoM=;
        b=LTvYXWpQ+ThTfSIfHOAtIXOnJk6C2GcJYBG5XE6f8TpUqy9tlsnIurRZDNhbvMGPw5
         exd0WibPVnxxQB1Lu96B+UkocaWP4ARcIejGxtAPSXFCRQZvsrx+OjI+n+zzebNyW/aE
         hR0SWboJLqu1IWkq/U+QQ54U83eACA7XgOdFmaxhBggQMWcD48hbPg+4OEgWolWJ1ACR
         5avNNb9/3oeve0yBBHFArQCEAl+rONPbLcWDFUlr3Ft2FSXdl9ztcyQr7AriwSZe0vMA
         ++wQJm6JezuD5xjeIzIKCpywP5UWMQaaz//YqxBkVdVMB3We0eciUNCFhJIzDMf5cnSG
         Mdfw==
X-Received: by 10.60.56.82 with SMTP id y18mr16498482oep.86.1374206845735;
 Thu, 18 Jul 2013 21:07:25 -0700 (PDT)
Received: by 10.76.69.169 with HTTP; Thu, 18 Jul 2013 21:07:05 -0700 (PDT)
In-Reply-To: <51E7EDE3.4080205@gmail.com>
X-Google-Sender-Auth: xWekOQx3IfMNUhJeh88q_mGCA1Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230779>

On Thu, Jul 18, 2013 at 9:30 AM, Drew Northup <n1xim.email@gmail.com> wrote:
>
> Somehow this patch breaks the main view to not open the correct commit in diff view when <enter> is pressed. Back to the debugger...

Does this (possibly white-space damaged) patch work for you?

diff --git a/tig.c b/tig.c
index ba9ba98..74a2928 100644
--- a/tig.c
+++ b/tig.c
@@ -3104,7 +3104,7 @@ format_expand_arg(struct format_context *format,
const char *name)
 static bool
 format_append_arg(struct format_context *format, const char
***dst_argv, const char *arg)
 {
- format->bufpos = 0;
+ format->buf[0] = format->bufpos = 0;

  while (arg) {
  char *next = strstr(arg, "%(");


--
Jonas Fonseca
