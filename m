From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetools: created new mergetool file for ExamDiff
Date: Sun, 20 Mar 2016 20:32:01 -0700
Message-ID: <20160321033201.GA2004@gmail.com>
References: <1458449932-24342-1-git-send-email-jacob.nisnevich@gmail.com>
 <xmqqfuvkod6o.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Nisnevich <jacob.nisnevich@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 04:32:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahqZl-0001MX-KI
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 04:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbcCUDcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 23:32:09 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34200 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbcCUDcH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 23:32:07 -0400
Received: by mail-pf0-f175.google.com with SMTP id x3so248369950pfb.1
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 20:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0RQVp0Yp1/VZlh+32tH+LgH1QzOoNbaGZMMYMwpXfv0=;
        b=KhwiGqR00w1zqLs2S4gJ0TkIH3C3/ZLLzNrDPTFSL7A/XWCnsI1dg4xrfPoiGdIAJ+
         2o/bDIHQo9Z/ZmIOx7yYLWSJKmzjdZ/hdo26mysvpbHN1prd59I0r8CCstyDZFX1flN0
         ts/DxgJBb8Iq/2aPFHLrgEG6bEDZGSVJuuv5DlMQbXej5JHHLprF/BotBgOQ1/ly9D5o
         6uTKQwz5T6X3pqMuGIgoh7g6AsV1/hEwpmmDZi+Gvtldl47kScCeGBPqMdk11hT+2FQf
         rw4WEDPa/DoMHXrn2YlfJhI9V6cqGyaMv3cdXjk1aOe36Hyns4pbJJrnc7GfcyookQBK
         gWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0RQVp0Yp1/VZlh+32tH+LgH1QzOoNbaGZMMYMwpXfv0=;
        b=iXDrP0NFJo6E9Kyv4pQ41unp3bl0Llg6SRQpLUO8G7ExKu3Zhu/LqRol7zFX9kCKlY
         TzQ7GuZnzNtZFPgrVNc88NNDvkoIV7CCO+AqTrC2NxXdazio1yio4khcNrNcCaR+2dUD
         DTlnqRb1kGwLds9oDQa4M0yOS85sEibv/bgmBSPuNf/YAjQ2Luvf5y+nusHGk6x7axed
         8JXxS5S/rgItcXaV/XJORIAvMVxI/Eqq1/tfL2DAvpCrxb0NW+3hcOjgrmkRrxTDbxcI
         uF+fc2nsH0Yp9p7aR3WvQNcE27P0F31qY+dDMYId+OqcNH0V88UxZdVpky6+fcTcdu49
         mwzQ==
X-Gm-Message-State: AD7BkJJXEErigJIXOlVXhbYeUssOzbP6vHN9GJKp/6qH8HvtYLHe3XY4ZkFSi4t0FNxHcQ==
X-Received: by 10.98.7.135 with SMTP id 7mr41547054pfh.124.1458531126337;
        Sun, 20 Mar 2016 20:32:06 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id m87sm36293413pfj.38.2016.03.20.20.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Mar 2016 20:32:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfuvkod6o.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289394>

On Sun, Mar 20, 2016 at 06:02:55PM -0700, Junio C Hamano wrote:
> Jacob Nisnevich <jacob.nisnevich@gmail.com> writes:
> 
> > ---
> 
> Missing sign-off.
> 
> I'll Cc the area expert (David Aguilar).
> 
> >  mergetools/examdiff | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 mergetools/examdiff
> >
> > diff --git a/mergetools/examdiff b/mergetools/examdiff
> > new file mode 100644
> > index 0000000..474fffe
> > --- /dev/null
> > +++ b/mergetools/examdiff
> > @@ -0,0 +1,37 @@
> > +diff_cmd () {
> > +	"$merge_tool_path" "$LOCAL" "$REMOTE" -nh
> > +}
> > +
> > +merge_cmd () {
> > +	touch "$BACKUP"
> > +	if $base_present
> > +	then
> > +		"$merge_tool_path" -merge "$LOCAL" "$BASE" "$REMOTE" -o:"$MERGED" -nh
> > +	else
> > +		"$merge_tool_path" -merge "$LOCAL" "$REMOTE" -o:"$MERGED" -nh
> > +	fi
> > +	check_unchanged
> > +}
> > +
> > +translate_merge_tool_path() {
> > +	# Use ExamDiff.com if it exists in $PATH
> > +	if type -p ExamDiff.com >/dev/null 2>&1
> > +	then
> > +		printf ExamDiff.com
> > +		return
> > +	fi
> > +
> > +	# Look for ExamDiff.com in the typical locations
> > +	examdiff="ExamDiff Pro/ExamDiff.com"
> > +	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
> > +		cut -d '=' -f 2- | sort -u)
> > +	do
> > +		if test -n "$directory" && test -x "$directory/$examdiff"
> > +		then
> > +			printf '%s' "$directory/$examdiff"
> > +			return
> > +		fi
> > +	done
> > +
> > +	printf ExamDiff.com
> 
> This complicated heuristics look like a cut-and-paste from the
> neighbouring winmerge; makes me suspect that they should share the
> same helper function to implement the bulk of the above code for
> better maintainability (e.g. imagine in the future Microsoft decides
> to introduce another directory organization and makes it necessary
> to tweak the pattern you give to 'grep -Ei'---WinMergeU user may
> notice that and fix it, while this script will be overlooked and
> will stay stale until somebody from examdiff camp do the same fix
> later).

I agree with that.

Something like mergetool_find_win32_cmd() might make sense as a
helper function that we can reuse here.

> > +}
> > \ No newline at end of file
> 
> No newline at end of file?

Using sublime text perhaps?
It defaults to not including the final line newline terminator.

https://forum.sublimetext.com/t/make-saving-newline-at-eof-the-installation-default/9842

If so, please configure it as detailed in the above thread.

cheers,
-- 
David
