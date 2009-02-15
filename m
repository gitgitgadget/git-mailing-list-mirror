From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/8] config: Disallow multiple config file locations.
Date: Sun, 15 Feb 2009 15:35:57 +0200
Message-ID: <20090215133557.GB13810@annwn>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-3-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-5-git-send-email-felipe.contreras@gmail.com> <alpine.DEB.1.00.0902151324530.10279@pacific.mpi-cbg.de> <94a0d4530902150444t6e4dcd3btda79aaa0efebfe62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 14:37:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYhBc-0001S0-98
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 14:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbZBONgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 08:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbZBONgE
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 08:36:04 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:46027 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbZBONgC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 08:36:02 -0500
Received: by fxm13 with SMTP id 13so4898477fxm.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 05:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tFXTvlaYk1B1r6kFR9KdorCUKgEfDEj8/UTJza9QVhc=;
        b=Lk5mmxxgtoSLAD1P8AEG7JvmDKgTnYjiGsLntdgNkX1swelf4jMQHswxAyIuZKmCxN
         gS5R3oUvl2de8+h2/eU2bn5Hz5t5aRvThVCS/mQDGCOK4BCcFdiVLg1QvhKQa8PVJE8d
         ugZZdWGX6fnfxDKOw4k6MwIjaknUNOMcxjjtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TemoVngd34iSNE1x+J+lVZofLwAmvLNNMXtMQ+sNMMPBy4QX8Pgibisjq1geMsKKFq
         YJyNvtOxxTjouDr6LuQWRNz1yrvU89tgeaOfq9fAvFRrVJeXPW2hconz9toqoolGQq7i
         7pYZPhf43qoIjusDjJM4PtVyBrhHIU9isqbg8=
Received: by 10.223.105.72 with SMTP id s8mr2449583fao.107.1234704960031;
        Sun, 15 Feb 2009 05:36:00 -0800 (PST)
Received: from @ (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id e17sm6046844fke.28.2009.02.15.05.35.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Feb 2009 05:35:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <94a0d4530902150444t6e4dcd3btda79aaa0efebfe62@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110009>

On Sun, Feb 15, 2009 at 02:44:29PM +0200, Felipe Contreras wrote:
> On Sun, Feb 15, 2009 at 2:26 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Sun, 15 Feb 2009, Felipe Contreras wrote:
> >
> >> Either --global, --system, or --file should be used, but not any
> >> combination.
> >>
> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >> ---
> >>  builtin-config.c |   10 ++++++++++
> >>  1 files changed, 10 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/builtin-config.c b/builtin-config.c
> >> index 83f8b74..e744ad8 100644
> >> --- a/builtin-config.c
> >> +++ b/builtin-config.c
> >> @@ -314,6 +314,16 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
> >>
> >>       argc = parse_options(argc, argv, builtin_config_options, builtin_config_usage, 0);
> >>
> >> +     {
> >> +             int config_file_count = use_global_config + use_system_config;
> >> +             if (given_config_file)
> >> +                     config_file_count++;
> >> +             if (config_file_count > 1) {
> >> +                     error("only one config file at a time.");
> >> +                     usage_with_options(builtin_config_usage, builtin_config_options);
> >> +             }
> >> +     }
> >
> > Hmm.  Is this a convoluted way to write
> >
> >        if (use_global_config + use_system_config + !!given_config_file > 1)
> >
> > or am I misunderstanding anything?
> 
> Ah, much better. (the !!foo trick is new to me)

Now inlined:

---
 builtin-config.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 30de93e..cdd8a12 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -313,6 +313,11 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 
 	argc = parse_options(argc, argv, builtin_config_options, builtin_config_usage, 0);
 
+	if (use_global_config + use_system_config + !!given_config_file > 1) {
+		error("only one config file at a time.");
+		usage_with_options(builtin_config_usage, builtin_config_options);
+	}
+
 	if (use_global_config) {
 		char *home = getenv("HOME");
 		if (home) {
-- 
1.6.1.3


-- 
Felipe Contreras
