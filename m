Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD71F1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 15:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfH0PdV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 11:33:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36805 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfH0PdV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 11:33:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id w2so14358948pfi.3
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=nTrdGljyw7nI2TVR/MM6vCqezKsYS80I264aiNLUG40=;
        b=d0UkhNLx9uEiVaPAVhJd0Z+iOpBSSAzAU38k1UASYYAreme3Sc3vul9XBXZFnEPNY3
         mdrQTEcIGYy0oj4le++N+tVMXt19YC5KrDlT7nxLJESU2TsjBJbHHeHDmdN0n+IJwgEu
         bSSSt7/ubtIPbeIyKXv9zIRMjccne3P/RF8hMNuED1kF9/5GtS/kBBGhILTkv8VsU6/s
         m3csWqtDOaFPpAuFHvu+bYCMqSZkNzcN2EnrYIhJzq5oElco3aDiWp3azJTEHKRa2NnN
         ZFeHFntSY2sNpPI53Dpm8F5kEamxAmjiOQsNjTwNwJ+IWHPmisGUoZgtfrDpnWVOZf1y
         WMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nTrdGljyw7nI2TVR/MM6vCqezKsYS80I264aiNLUG40=;
        b=DXFf2EGCduGlnMwVkJMAsKgGhI77eR0KwGa3D61Vg26R+ycCoM84tf8pn6knyjdm58
         BDTNOOKndVCLt8H7uv8J6ZZ3ka9lNh+wT7p4Re2RQpDvWHR4cIFF3VQTntgZNiFhKwWL
         dISzzRIh3DqTUdnySDRG4p3iDCed2CkkoujEKy4/yIXV2LLxVjqTcX+wYvH9tiqR8v9m
         1NBCR58g6IOe5TUKPnIi/rd63kikMtuXi6HX1Oc2/c46Q/jOk19tAEsyI68z8GYilcby
         A5ZIUPcqYGx2/0vLtxpg6JVtcXklujAXn/i7z4Q9Ks6X4dzihk4AjsT+A5E4iSVYAB+X
         fEgQ==
X-Gm-Message-State: APjAAAWabOFvEg7u2Hxio87lFj6DKPBaAN/aTIbpoRMAnxHV8UUEaOQf
        7wvGxI5/fL4HiDkajfOhL3rUA+3zz+pLHw==
X-Google-Smtp-Source: APXvYqxnQAJehvGX6OleR9GCc+bOvoIyW0NxJ0oWR5VYZSkyYSjIvM/4Q8Z2l3qhKb5AwElgJaPMzQ==
X-Received: by 2002:a63:20a:: with SMTP id 10mr21537575pgc.226.1566919999501;
        Tue, 27 Aug 2019 08:33:19 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id 6sm15471870pfa.7.2019.08.27.08.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 08:33:18 -0700 (PDT)
Subject: Re: [PATCH] gitk: Make web links clickable
To:     Paul Mackerras <paulus@ozlabs.org>, git@vger.kernel.org
References: <20190826221444.GB7402@blackberry>
From:   Barret Rhoden <brho@google.com>
Message-ID: <24ec7841-0996-b3d7-81b4-f48a446341ee@google.com>
Date:   Tue, 27 Aug 2019 11:33:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190826221444.GB7402@blackberry>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/26/19 6:14 PM, Paul Mackerras wrote:
> This makes gitk look for lines in the commit message which start with
> "Link:" or "BugLink:" followed by a http or https URL, and make the
> URL clickable.  Clicking on it will invoke an external web browser with
> the URL.
> 
> The web browser command is by default "xdg-open" on Linux, "open" on
> MacOS, and "cmd /c start" on Windows.  The command can be changed in
> the preferences window, and it can include parameters as well as the
> command name.  If it is set to the empty string then URLs will no
> longer be made clickable.
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

FWIW:

Tested-by: Barret Rhoden <brho@google.com>


> ---
>   gitk | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/gitk b/gitk
> index a14d7a1..4577150 100755
> --- a/gitk
> +++ b/gitk
> @@ -7016,6 +7016,7 @@ proc commit_descriptor {p} {
>   
>   # append some text to the ctext widget, and make any SHA1 ID
>   # that we know about be a clickable link.
> +# Also look for lines of the form "Link: http..." and make them web links.
>   proc appendwithlinks {text tags} {
>       global ctext linknum curview
>   
> @@ -7032,6 +7033,18 @@ proc appendwithlinks {text tags} {
>   	setlink $linkid link$linknum
>   	incr linknum
>       }
> +    set wlinks [regexp -indices -all -inline -line \
> +		    {^ *(Bug|)Link: (https?://.*)$} $text]
> +    foreach {l sub1 sub2} $wlinks {
> +	set s2 [lindex $sub2 0]
> +	set e2 [lindex $sub2 1]
> +	set url [string range $text $s2 $e2]
> +	incr e2
> +	$ctext tag delete link$linknum
> +	$ctext tag add link$linknum "$start + $s2 c" "$start + $e2 c"
> +	setwlink $url link$linknum
> +	incr linknum
> +    }
>   }
>   
>   proc setlink {id lk} {
> @@ -7064,6 +7077,18 @@ proc setlink {id lk} {
>       }
>   }
>   
> +proc setwlink {url lk} {
> +    global ctext
> +    global linkfgcolor
> +    global web_browser
> +
> +    if {$web_browser eq {}} return
> +    $ctext tag conf $lk -foreground $linkfgcolor -underline 1
> +    $ctext tag bind $lk <1> [list browseweb $url]
> +    $ctext tag bind $lk <Enter> {linkcursor %W 1}
> +    $ctext tag bind $lk <Leave> {linkcursor %W -1}
> +}
> +
>   proc appendshortlink {id {pre {}} {post {}}} {
>       global ctext linknum
>   
> @@ -7098,6 +7123,16 @@ proc linkcursor {w inc} {
>       }
>   }
>   
> +proc browseweb {url} {
> +    global web_browser
> +
> +    if {$web_browser eq {}} return
> +    # Use eval here in case $web_browser is a command plus some arguments
> +    if {[catch {eval exec $web_browser [list $url] &} err]} {
> +	error_popup "[mc "Error starting web browser:"] $err"
> +    }
> +}
> +
>   proc viewnextline {dir} {
>       global canv linespc
>   
> @@ -11488,7 +11523,7 @@ proc create_prefs_page {w} {
>   proc prefspage_general {notebook} {
>       global NS maxwidth maxgraphpct showneartags showlocalchanges
>       global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
> -    global hideremotes want_ttk have_ttk maxrefs
> +    global hideremotes want_ttk have_ttk maxrefs web_browser
>   
>       set page [create_prefs_page $notebook.general]
>   
> @@ -11539,6 +11574,13 @@ proc prefspage_general {notebook} {
>       pack configure $page.extdifff.l -padx 10
>       grid x $page.extdifff $page.extdifft -sticky ew
>   
> +    ${NS}::entry $page.webbrowser -textvariable web_browser
> +    ${NS}::frame $page.webbrowserf
> +    ${NS}::label $page.webbrowserf.l -text [mc "Web browser" ]
> +    pack $page.webbrowserf.l -side left
> +    pack configure $page.webbrowserf.l -padx 10
> +    grid x $page.webbrowserf $page.webbrowser -sticky ew
> +
>       ${NS}::label $page.lgen -text [mc "General options"]
>       grid $page.lgen - -sticky w -pady 10
>       ${NS}::checkbutton $page.want_ttk -variable want_ttk \
> @@ -12310,6 +12352,7 @@ if {[tk windowingsystem] eq "win32"} {
>       set bgcolor SystemWindow
>       set fgcolor SystemWindowText
>       set selectbgcolor SystemHighlight
> +    set web_browser "cmd /c start"
>   } else {
>       set uicolor grey85
>       set uifgcolor black
> @@ -12317,6 +12360,11 @@ if {[tk windowingsystem] eq "win32"} {
>       set bgcolor white
>       set fgcolor black
>       set selectbgcolor gray85
> +    if {[tk windowingsystem] eq "aqua"} {
> +	set web_browser "open"
> +    } else {
> +	set web_browser "xdg-open"
> +    }
>   }
>   set diffcolors {red "#00a000" blue}
>   set diffcontext 3
> @@ -12390,6 +12438,7 @@ set config_variables {
>       filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
>       linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
>       indexcirclecolor circlecolors linkfgcolor circleoutlinecolor
> +    web_browser
>   }
>   foreach var $config_variables {
>       config_init_trace $var
> 

