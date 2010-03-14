From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH 3/3] git-send-email.perl - Fix 550 EHLO argument does not match calling host
Date: Sun, 14 Mar 2010 22:20:25 +0200
Organization: Private
Message-ID: <877hpebqpi.fsf@jondo.cante.net>
References: <4B97C157.4020806@gmail.com>
	<20100311081213.GA13575@sigill.intra.peff.net>
	<20100311083148.GA13786@sigill.intra.peff.net>
	<7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
	<7vy6hxnnfx.fsf@alter.siamese.dyndns.org>
	<87bpesi0om.fsf_-_@jondo.cante.net>
	<7vfx433l9x.fsf@alter.siamese.dyndns.org>
	<87eijng4hy.fsf@jondo.cante.net>
	<7vtysjs9hi.fsf@alter.siamese.dyndns.org>
	<878w9vdx01.fsf@jondo.cante.net> <87sk83aq76.fsf_-_@jondo.cante.net>
	<m3y6huk7f4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 14 21:20:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NquIm-0006w6-Dp
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 21:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab0CNUUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 16:20:39 -0400
Received: from lo.gmane.org ([80.91.229.12]:39703 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237Ab0CNUUi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 16:20:38 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NquIf-0006uQ-31
	for git@vger.kernel.org; Sun, 14 Mar 2010 21:20:37 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 21:20:37 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 21:20:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:NvqWAXCx1bVAKOVDqreykZa4jGI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142151>

Jakub Narebski <jnareb@gmail.com> writes:

> Nice... although it might be better to use Test::Reporter::Mail::Util

Done.

>> +sub maildomain_net
> Here should be a comment 'following what Test::Reporter does' or
> something like that.

Done.

> Sidenote: alternate soultion would be to write (with one less level of
> indent):

Done all.

>> +sub maildomain_mta
>> +{
>
> Use the same Perl convention that used elsewhere in git-send-email.perl
> (this is usually used Perl style).
>
> +sub maildomain_mta {

The code uses variety of styles. The function below, where the
maildomain*() are related used:

    sub send_message
    {

Do I keep the "sub....\n{" ?

Jari

-----------------------------------------------------------------------

sub new {
        my ($class, $reason) = @_;
        return bless \$reason, shift;
--
sub readline {
        my $self = shift;
        die "Cannot use readline on FakeTerm: $$self";
--
sub usage {
        print <<EOT;
git send-email [options] <file | directory | rev-list options >
--
sub format_2822_time {
        my ($time) = @_;
        my @localtm = localtime($time);
--
sub unique_email_list(@);
sub cleanup_compose_files();

# Variables we fill in automatically, or via prompting:
--
sub do_edit {
        if (defined($multiedit) && !$multiedit) {
                map {
--
sub chain_reply_to {
        if (defined $chain_reply_to &&
            $chain_reply_to eq $not_set_by_user) {
--
sub signal_handler {

        # Make text normal
--
sub read_config {
        my ($prefix) = @_;

--
sub parse_address_line {
        if ($have_mail_address) {
                return map { $_->format } Mail::Address->parse($_[0]);
--
sub split_addrs {
        return quotewords('\s*,\s*', 1, @_);
}
--
sub check_file_rev_conflict($) {
        return unless $repo;
        my $f = shift;
--
sub get_patch_subject($) {
        my $fn = shift;
        open (my $fh, '<', $fn);
--
sub ask {
        my ($prompt, %arg) = @_;
        my $valid_re = $arg{valid_re};
--
sub expand_aliases {
        return map { expand_one_alias($_) } @_;
}
--
sub expand_one_alias {
        my $alias = shift;
        if ($EXPANDED_ALIASES{$alias}) {
--
sub extract_valid_address {
        my $address = shift;
        my $local_part_regexp = '[^<>"\s@]+';
--
sub make_message_id
{
        my $uniq;
--
sub unquote_rfc2047 {
        local ($_) = @_;
        my $encoding;
--
sub quote_rfc2047 {
        local $_ = shift;
        my $encoding = shift || 'UTF-8';
--
sub is_rfc2047_quoted {
        my $s = shift;
        my $token = '[^][()<>@,;:"\/?.= \000-\037\177-\377]+';
--
sub sanitize_address
{
        my ($recipient) = @_;
--
sub maildomain_net
{
        my $maildomain;
--
sub maildomain_mta
{
        my $maildomain;
--
sub maildomain
{
        return maildomain_net() || maildomain_mta() || $mail_domain_default;
--
sub send_message
{
        my @recipients = unique_email_list(@to);
--
sub cleanup_compose_files() {
        unlink($compose_filename, $compose_filename . ".final") if $compose;
}
--
sub unique_email_list(@) {
        my %seen;
        my @emails;
--
sub validate_patch {
        my $fn = shift;
        open(my $fh, '<', $fn)
--
sub file_has_nonascii {
        my $fn = shift;
        open(my $fh, '<', $fn)
