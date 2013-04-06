From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: remove --graph in hg_log()
Date: Sat, 6 Apr 2013 10:32:10 -0600
Message-ID: <CAMP44s1RhMR4vkUqbOOqQ+VAHVQgO8SCrBSSGNjCD-buGnb10g@mail.gmail.com>
References: <1365264055-30507-1-git-send-email-apelisse@gmail.com>
	<CAMP44s2tdKhGuH3E7nGqU4R3jgEw4tH-=Cq6dhHwiLc=b_fm6Q@mail.gmail.com>
	<CALWbr2yhZW46RB=8gUivcN4r5NFhk0y-0ND-X2c8ALKos6qi=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:52:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWX0-0001D7-9S
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423305Ab3DFQcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 12:32:12 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41243 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423300Ab3DFQcM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 12:32:12 -0400
Received: by mail-lb0-f174.google.com with SMTP id s10so4626741lbi.33
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=MUXjarNh3u4HWBqtLFfQzTh2FoBVbzxH2KzPNG0lx48=;
        b=IVMuyCvZ+C3iREdmz61VJBzeoTIt5l0xyKjLRbtpPKM2GIya7aDKT1JH1LYellD1BW
         2HAU1nvsLOpoNciHbdOUsG951dnzL3pkpx66IPYzvxxzTbVoLaoW+jcI29gTouJl+GOI
         SfQ3+sqUZUT1AWfdJea2JiPnWDks2qXWnD78pYaIOquecl1VwFgsqmPcBHkr8HN0u2Aa
         c0hRsLe8OQq5XfwlrVFSNPCL9sLcnn/XkisYgHPRSLfumtu+HnECn9tLqYRUZul+DycY
         hlljisr2gpLJcUsC0WrSfBzZcKZdzRcPBGiO42JxhZeWr+T/2jL+KCp7uNB/frPCO+jF
         BTHA==
X-Received: by 10.152.147.36 with SMTP id th4mr8672885lab.19.1365265930182;
 Sat, 06 Apr 2013 09:32:10 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sat, 6 Apr 2013 09:32:10 -0700 (PDT)
In-Reply-To: <CALWbr2yhZW46RB=8gUivcN4r5NFhk0y-0ND-X2c8ALKos6qi=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220239>

On Sat, Apr 6, 2013 at 10:12 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Sat, Apr 6, 2013 at 6:06 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sat, Apr 6, 2013 at 10:00 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
>>> I'm not so confident that --graph is useless to the test. If it's really
>>> necessary, it would be nice either to activate it in setup() or to use
>>> it just for the command through: "--config extensions.graphlog=".
>>
>> I think it should be activated in the setup, it comes packaged with
>> mercurial, and it's likely that many users have it enabled.
>
> But is it relevant to the tests ? I have the feeling that it's not
> strictly necessary to both add an extension to hgrc and a command line
> option. (and indeed, the tests still work for me, but maybe I'm
> missing something).

It's possible that the order of the commits make them look the same,
but the topology is different. At least I saw a couple of cases when I
was working on them, but of course, that was on test-hg-hg-git.sh,
which should also have a patch. I think adding it in hgrc is the best
option.

-- 
Felipe Contreras
