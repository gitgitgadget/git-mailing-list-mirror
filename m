Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6A91FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 17:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbdFVRcH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 13:32:07 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32857 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbdFVRcG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 13:32:06 -0400
Received: by mail-pg0-f66.google.com with SMTP id u62so3285119pgb.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=D9L6JQ4tSIsCKcpKS6sznZlzhdKmrKNYhIQTV+AyPFc=;
        b=S7GMbcgomr8EVlnDBjstjOMRhExcELD9z4vGyKchF3seRIzc/yVvSRfkAeQfH4TOH1
         QhdhTbOzF0SZMxvvOLfYckjXfxrVsP3lwwMMmXCAFRAIKK0eWAz4ZAqiIX9SkEj+yJxE
         fkObe/TDX2/aAZExu0rdW4si4PQYpsr/jJWi8GcsQErtSgfq+3PyTiWYciWmzVmu5P0o
         IqRCmKW4QT3LUr89ImWWmUYxq7jRnw7Ll3v45/lD0/tgJHXEvY3BGGGtyx5WK6jJo/q9
         qo7W8zrrdfYKUzOuQbliB5AAEKrzbAiKBieBRrhD2KJ/nyBQ/eathXkDgBZySnXEmsq4
         nTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=D9L6JQ4tSIsCKcpKS6sznZlzhdKmrKNYhIQTV+AyPFc=;
        b=mGAgaF+ZzHqTxja//b+H7aVVSfjsYXJg8KSC7crEx1pS1QZOQDfwj2bzG5HBD7kPER
         XTFqC5WMMc504eapag0ahvtIXaIDV0hTWQWtSQ6kwnIJszJQmdkcsOwkJZ14gqB5PSBZ
         Y3ZjafFLOAZclWcsAof1z3+9WYZN882toNZicY0U8ibfTKug9noBOxUI/48vOqZKWDZj
         9UmS3MJCQoNICEU9P5nMWIQanUhJWiNdGvQPdKtsVSRvjYxcR2+k3Di2jWkCo8E+sbW5
         z+DCkndpYKxkB104qUTEF7qsPhsS3fBDSEBtqVeyKz12NW4EnrKoRsuyOsM2z2jjjM8Q
         7W0Q==
X-Gm-Message-State: AKS2vOz96HC+7Wxk6jRE7TUVdk5iteow5FIJ4YFODuCkI/g2X3iNbN8L
        7wDOOd15G4pb7g==
X-Received: by 10.84.217.206 with SMTP id d14mr4114100plj.121.1498152725749;
        Thu, 22 Jun 2017 10:32:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id s131sm4922704pgs.6.2017.06.22.10.32.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 10:32:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, Miguel Torroja <miguel.torroja@gmail.com>
Subject: Re: [PATCH] git-p4: changelist template with p4 -G change -o
References: <1497961141-3144-1-git-send-email-miguel.torroja@gmail.com>
Date:   Thu, 22 Jun 2017 10:32:03 -0700
In-Reply-To: <1497961141-3144-1-git-send-email-miguel.torroja@gmail.com>
        (Miguel Torroja's message of "Tue, 20 Jun 2017 14:19:01 +0200")
Message-ID: <xmqq4lv8kjxo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miguel Torroja <miguel.torroja@gmail.com> writes:

> The option -G of p4 (python marshal output) gives more context about the
> data being output. That's useful when using the command "change -o" as
> we can distinguish between warning/error line and real change description.
>
> Some p4 plugin/hooks in the server side generates some warnings when
> executed. Unfortunately those messages are mixed with the output of
> "p4 change -o". Those extra warning lines are reported as {'code':'info'}
> in python marshal output (-G). The real change output is reported as
> {'code':'stat'}
>
> Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
> ---

Asking for help reviewing to those who have worked on git-p4 in the
past...

Thanks.

>  git-p4.py | 77 ++++++++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 51 insertions(+), 26 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 8d151da..a300474 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1526,37 +1526,62 @@ class P4Submit(Command, P4UserMap):
>  
>          [upstream, settings] = findUpstreamBranchPoint()
>  
> -        template = ""
> +        template = """\
> +# A Perforce Change Specification.
> +#
> +#  Change:      The change number. 'new' on a new changelist.
> +#  Date:        The date this specification was last modified.
> +#  Client:      The client on which the changelist was created.  Read-only.
> +#  User:        The user who created the changelist.
> +#  Status:      Either 'pending' or 'submitted'. Read-only.
> +#  Type:        Either 'public' or 'restricted'. Default is 'public'.
> +#  Description: Comments about the changelist.  Required.
> +#  Jobs:        What opened jobs are to be closed by this changelist.
> +#               You may delete jobs from this list.  (New changelists only.)
> +#  Files:       What opened files from the default changelist are to be added
> +#               to this changelist.  You may delete files from this list.
> +#               (New changelists only.)
> +"""
> +        files_list = []
>          inFilesSection = False
> +        change_entry = None
>          args = ['change', '-o']
>          if changelist:
>              args.append(str(changelist))
> -
> -        for line in p4_read_pipe_lines(args):
> -            if line.endswith("\r\n"):
> -                line = line[:-2] + "\n"
> -            if inFilesSection:
> -                if line.startswith("\t"):
> -                    # path starts and ends with a tab
> -                    path = line[1:]
> -                    lastTab = path.rfind("\t")
> -                    if lastTab != -1:
> -                        path = path[:lastTab]
> -                        if settings.has_key('depot-paths'):
> -                            if not [p for p in settings['depot-paths']
> -                                    if p4PathStartsWith(path, p)]:
> -                                continue
> -                        else:
> -                            if not p4PathStartsWith(path, self.depotPath):
> -                                continue
> +        for entry in p4CmdList(args):
> +            if not entry.has_key('code'):
> +                continue
> +            if entry['code'] == 'stat':
> +                change_entry = entry
> +                break
> +        if not change_entry:
> +            die('Failed to decode output of p4 change -o')
> +        for key, value in change_entry.iteritems():
> +            if key.startswith('File'):
> +                if settings.has_key('depot-paths'):
> +                    if not [p for p in settings['depot-paths']
> +                            if p4PathStartsWith(value, p)]:
> +                        continue
>                  else:
> -                    inFilesSection = False
> -            else:
> -                if line.startswith("Files:"):
> -                    inFilesSection = True
> -
> -            template += line
> -
> +                    if not p4PathStartsWith(value, self.depotPath):
> +                        continue
> +                files_list.append(value)
> +                continue
> +        # Output in the order expected by prepareLogMessage
> +        for key in ['Change','Client','User','Status','Description','Jobs']:
> +            if not change_entry.has_key(key):
> +                continue
> +            template += '\n'
> +            template += key + ':'
> +            if key == 'Description':
> +                template += '\n'
> +            for field_line in change_entry[key].splitlines():
> +                template += '\t'+field_line+'\n'
> +        if len(files_list) > 0:
> +            template += '\n'
> +            template += 'Files:\n'
> +        for path in files_list:
> +            template += '\t'+path+'\n'
>          return template
>  
>      def edit_template(self, template_file):
