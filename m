From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: Add new option to open an editor.
Date: Wed, 4 Feb 2009 01:25:26 +0200
Message-ID: <94a0d4530902031525o11e512barfc2f50c33a520474@mail.gmail.com>
References: <1233700826-11763-1-git-send-email-felipe.contreras@gmail.com>
	 <alpine.DEB.1.00.0902032350130.9822@pacific.mpi-cbg.de>
	 <94a0d4530902031456u1e1753e2rc34786ebdce6e774@mail.gmail.com>
	 <alpine.DEB.1.00.0902040002360.9822@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 00:27:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUfu-0007K0-Uy
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbZBCXZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbZBCXZa
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:25:30 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:64518 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbZBCXZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Feb 2009 18:25:28 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1049449fgg.17
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 15:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=39RfxmBXVQ8I7Cm769lqRsvnZM774vO7PJOtJVievnY=;
        b=gsnGqZhr/HVx2Db9J+gC4j11tbG5GAbXPaRSsUfZZPjxbMSJAh1FJUpUveJVS5HepE
         tampLjDMrobu2nlhRGvtObDwBohJcUTNWU017ys/57K+vrIEScoLit+WPf2O1M4vkcik
         d800hOLmcncs+vQI6g/KWTeP1rBLSj2npxK+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AkQKkM7bDyhEuEmgtUWo01/N/5KwhqztQGwDxgua/ZgSR+jUTQLAT4jHtKzNeeANf2
         sWkM2aBMlQplNEbmswdun2PuauLxhM06NMLlfVCTGTVTYc9QphmC0LdCDs+rtxySgu+X
         SavqMfUIY3yZLuYvV8BdCN2rSJQSsOLFHfZBs=
Received: by 10.86.95.8 with SMTP id s8mr825145fgb.79.1233703526259; Tue, 03 
	Feb 2009 15:25:26 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902040002360.9822@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108268>

On Wed, Feb 4, 2009 at 1:05 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 4 Feb 2009, Felipe Contreras wrote:
>
>> On Wed, Feb 4, 2009 at 12:53 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > On Wed, 4 Feb 2009, Felipe Contreras wrote:
>> >
>> >>  static const char git_config_set_usage[] =
>> >> -"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty]";
>> >> +"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty] | --edit | -e ]";
>> >
>> > This line is getting way too long...  (Not nit-picking your current patch,
>> > but maybe you could provide another patch to break the line, while you're
>> > at builtin-config.c already.  Maybe even parseopt'ifying it... ;-)
>>
>> Yeah, I'll send another patch to clean that string. Is there any
>> example of that parseopt thing?
>
> Yep... test-parse-options.c ;-)

Cool, I'll check that.

>> >> @@ -362,6 +362,15 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>> >>                       return get_color(argc-2, argv+2);
>> >>               } else if (!strcmp(argv[1], "--get-colorbool")) {
>> >>                       return get_colorbool(argc-2, argv+2);
>> >> +             } else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
>> >> +                     char *config_filename;
>> >> +                     if (config_exclusive_filename)
>> >> +                             config_filename = xstrdup(config_exclusive_filename);
>> >> +                     else
>> >> +                             config_filename = git_pathdup("config");
>> >> +                     launch_editor(config_filename, NULL, NULL);
>> >> +                     free(config_filename);
>> >> +                     return 0;
>> >
>> > Does launch_editor() not take a 'const char *' on purpose?  IOW you do not
>> > need to xstrdup() the filename.  You do not even need git_pathdup(), as
>> > launch_editor() does not use git_path() itself.
>>
>> So, s/git_pathdup/git_path/ ?
>
> And s/xstrdup(\(.*\))/\1/.

Yeah, I understood that.

>> > However, a test case would be nice...
>>
>> What would the the test case check?
>
> That 'GIT_CONFIG=bla GIT_EDITOR=echo git config -e' and 'GIT_DIR=blub
> GIT_EDITOR=echo git config -e' do the right thing.  Maybe even --global,
> but that would also be a good test that "git config --global -e" does not
> fail when there is no original file.

Hmm, I'm not sure what issues this test case would find. If there's a
problem with launch_editor that's something other test case should
find.

If there's no original file it's up to the editor to create one, if
for some reason the editor fails at doing that it's a problem of the
editor, and there's not much 'git config -e' could do except show an
error, and that's what launch_editor would do. Same thing if the
editor is wrong (GIT_EDITOR=blah).

I'll resend.

-- 
Felipe Contreras
